require "rails_helper"

RSpec.describe Meal do
  it "has valid test data" do
    meal = create(:meal)
    expect(meal).to be_valid
  end

  it "must have a food and date_of" do
    invalid_meal = Meal.new
    expect(invalid_meal).not_to be_valid
    expect(invalid_meal.errors[:food]).to include("can't be blank")
    expect(invalid_meal.errors[:date_of]).to include("can't be blank")
  end

  it "must have a unique date_of" do
    meal = create(:meal)
    copy_cat = Meal.new(date_of: meal.date_of)
    expect(copy_cat).not_to be_valid
    expect(copy_cat.errors[:date_of]).to include("has already been taken")
  end

  it "orders by reverse chronological order" do
    peas = Meal.create!(food: "Peas", date_of: "2016-09-01")
    cheese = Meal.create!(food: "Cheese", date_of: "2016-09-02")
    expect(Meal.recent).to eq([cheese, peas])
  end
end
