# frozen_string_literal: true

class TicketReservation
  NotEnoughTicketsError = Class.new(StandardError)

  def self.call(ticket, tickets_count)
    available_tickets = ticket.available
    raise NotEnoughTicketsError, "Not enough tickets left." unless available_tickets >= tickets_count
    ticket.update(available: available_tickets - tickets_count)
  end
end
