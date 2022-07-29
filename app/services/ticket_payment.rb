# frozen_string_literal: true

class TicketPayment
  ReservationNotFound = Class.new(StandardError)

  def self.call(user_id, payment_token, event)
    reservations = event.ticket.reservations.where(user_id: user_id)
    raise ReservationNotFound, "Reservation not found." unless reservations.count > 0
    ticket_price = event.ticket.price
    total_tickets = reservations.inject(0) { |sum, reservation| sum + reservation.tickets_count }
    Payment::Gateway.charge(amount: (ticket_price * total_tickets), token: payment_token)
    reservations.destroy_all
  end
end
