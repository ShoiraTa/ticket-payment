# frozen_string_literal: true

class ReservationExpiredWorker
  include Sidekiq::Worker
  def perform
    Reservation.created_15_min_ago.map do |reservation|
      reservation.ticket.update(available: reservation.ticket.available + reservation.tickets_count)
      reservation.destroy
    end
  end
end
