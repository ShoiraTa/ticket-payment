# frozen_string_literal: true

RSpec.describe TicketReservation do
  describe ".call" do
    let(:event) { create(:event, :with_ticket) }
    let(:ticket) { create(:ticket, :with_reservation) }
    let(:user_id) { 1 }
    let(:tickets_count) { 1 }

    subject { described_class.call(ticket, tickets_count) }
    context "when tickets are available" do
      it "should update available tickets count" do
        expect { subject }.to change(ticket, :available).by(-1)
      end

      it "should create a reservation" do
        expect { subject }.to change{Reservation.count}
      end
    end

    context "when tickets are not available" do
      let(:tickets_count) { ticket.available + 1 }
      it "should raise error" do
        expect { subject }.to raise_error(TicketReservation::NotEnoughTicketsError)
      end
    end
  end
end
