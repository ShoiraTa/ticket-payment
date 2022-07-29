# frozen_string_literal: true

require "rails_helper" # include in your RSpec file
require "sidekiq/testing" # include in your Rspec file
Sidekiq::Testing.fake! # include in your RSpec file

RSpec.describe ReservationExpiredWorker, type: :worker do
  let(:time) { (Time.zone.today + 6.hours).to_datetime }
  let(:scheduled_job) { ReservationExpiredWorker.perform_at(1.minutes.from_now) }
  describe "testing worker" do
    context "job is being added to queue" do
      it "job in correct queue" do
        scheduled_job
        assert_equal "default", described_class.queue
      end
      it "goes into the jobs array for testing environment" do
        expect do
          scheduled_job
        end.to change(described_class.jobs, :size).by(1)
        ReservationExpiredWorker.new.perform
      end
      it "occurs at expected time" do
        scheduled_job
        assert_equal true, described_class.jobs.last["jid"].include?(scheduled_job)
      end
    end
  end
end
