# frozen_string_literal: true

class TicketPaymentWorker
  include Sidekiq::Worker

  def perform(ticket_id, payment_token, tickets_count)
    @ticket = Ticket.find_by_id(ticket_id)
    begin
      Payment::Gateway.charge(amount: @ticket.price, token: payment_token)
    rescue
      available_tickets = @ticket.available
      @ticket.update(available: available_tickets + tickets_count)
    end
  end
end
