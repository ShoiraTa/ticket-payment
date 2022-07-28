class Reservation < ApplicationRecord
  belongs_to :ticket
  scope :created_15_min_ago, -> { where('created_at < ?', 1.minutes.ago) }
end
