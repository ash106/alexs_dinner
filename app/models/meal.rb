class Meal < ApplicationRecord
  validates :food, presence: true
  validates :date_of, presence: true
end
