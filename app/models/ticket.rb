# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :event
  has_many :reservations
end
