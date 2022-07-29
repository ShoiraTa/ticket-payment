# frozen_string_literal: true

require "spec_helper"
require "sidekiq/testing/inline"
# require 'sidekiq-status/testing/inline'

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true
  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = true # default => true
  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
end
