# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    event
    available { 10 }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    trait :with_reservation do
      after(:create) do |ticket|
        create(:reservation, ticket: ticket)
      end
    end
  end
end
