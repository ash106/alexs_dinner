class Meal < ApplicationRecord
  validates :food, presence: true
  validates :date_of, presence: true, uniqueness: true
  scope :recent, -> { order(date_of: :desc) }
end
