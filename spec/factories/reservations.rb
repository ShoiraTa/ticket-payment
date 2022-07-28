# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    ticket
    user_id { 1 }
    tickets_count { 1 }
  end
end
