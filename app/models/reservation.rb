# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :ticket
  scope :created_15_min_ago, -> { where("created_at < ?", 15.minutes.ago) }
end
