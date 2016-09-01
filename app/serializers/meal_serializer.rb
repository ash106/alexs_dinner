class MealSerializer < ActiveModel::Serializer
  attributes :food
  attribute :date_of, key: :date
end
