# frozen_string_literal: true

RSpec.describe TicketPayment do
  describe ".call" do
    context "when tickets are available" do
      before do
        @ticket = Ticket.create(event: event, available: 10, price: 100)
        @res = @ticket.reservations.create(user_id: user_id, tickets_count: tickets_count)
      end
      subject { described_class.call(user_id, token, event) }
      let(:event) { create(:event, :with_ticket) }
      let(:token) { "token" }
      let(:user_id) { 1 }
      let(:tickets_count) { 2 }
      it "should call payment adapter" do
        expect(Payment::Gateway).to receive(:charge).with(amount: (@ticket.price * tickets_count), token: token)
        subject
      end

      it "removes the record from the database after purchase is processed" do
        expect { TicketPayment.call(user_id, token, event) }.to change(Reservation, :count).by(-1)
      end
    end
  end
end
