# frozen_string_literal: true
# # frozen_string_literal: true

# RSpec.describe TicketPayment do
#   describe ".call" do
#     before do
#       @ticket = Ticket.create(event: event, available: 10, price: 100)
#       @ticket.reservations.create(user_id: user_id, tickets_count: tickets_count )
#     end

#     subject { described_class.call(user_id, token, event) }
#     let(:event) { create(:event, :with_ticket) }
#     let(:token) { "token" }
#     let(:user_id) { 1 }
#     let(:tickets_count) { 2 }

#     context "when tickets are available" do
#       it "should call payment adapter" do
#         expect(Payment::Gateway).to receive(:charge).with(amount: (@ticket.price * tickets_count), token: token)
#         subject
#       end

#       # it "should update available tickets count" do
#       #   expect { subject }.to change(ticket, :available).by(-1)
#       # end
#     end

#     # context "when tickets are not available" do
#     #   let(:tickets_count) { ticket.available + 1 }

#     #   it "should raise error" do
#     #     expect { subject }.to raise_error(TicketPayment::NotEnoughTicketsError)
#     #   end
#     # end
#   end
# end
