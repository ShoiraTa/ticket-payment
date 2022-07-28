# frozen_string_literal: true

class TicketsController < ApiController
  before_action :set_event
  before_action :set_tickets

  def index
    render :index
  end

  def buy
    payment_token = params[:token]
    user_id = params[:user_id]
    TicketPayment.call(user_id, payment_token, @event)
    render json: { success: "Payment succeeded." }
  end

  def reserve
    tickets_count = params[:tickets_count].to_i
    return wrong_number_of_tickets unless tickets_count > 0
    @reservation = @event.ticket.reservations.new(reservation_params)
    TicketReservation.call(@event.ticket, tickets_count)
    if @reservation.save
      render json: { success: "Reservation succeeded." }
    end
    ReservationExpiredWorker.perform_at(1.minutes.from_now)
  end

  private

  def ticket_params
    params.permit(:event_id, :token, :tickets_count)
  end

  def reservation_params
    params.permit(:tickets_count, :user_id)
  end

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound => error
    not_found_error(error)
  end

  def set_tickets
    @tickets = @event.ticket
    if @tickets.present?
      @tickets
    else
      render json: { error: "Ticket not found." }, status: :not_found
    end
  end

  def wrong_number_of_tickets
    render json: { error: "Number of tickets must be greater than zero." }, status: :unprocessable_entity
  end

  def not_enough_tickets
    render json: { error: "Not enough tickets left." }, status: :unprocessable_entity
  end
end
