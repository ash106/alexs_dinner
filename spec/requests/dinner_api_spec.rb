require "rails_helper"

RSpec.describe Dinner::API do
  context 'GET /api/v1/dinner/today.json' do
    it 'returns an empty array if there is no meal for today' do
      get '/api/v1/dinner/today.json'
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end

    it 'returns an array containing one meal if there is a meal for today' do
      meal = Meal.create(food: "Pizza", date_of: Date.current)
      get '/api/v1/dinner/today.json'
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body[0]["food"]).to eq(meal.food)
      expect(response_body[0]["date"]).to eq(meal.date_of.to_s)
    end
  end
  
  context 'GET /api/v1/dinner/recent.json' do
    it 'returns up to five most recent meals in reverse chronological order' do
      meal_yesterday = Meal.create(food: "Pizza", date_of: Date.yesterday)
      meal_today = Meal.create(food: "Corndogs", date_of: Date.current)
      get '/api/v1/dinner/recent.json'
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body[0]["food"]).to eq(meal_today.food)
      expect(response_body[0]["date"]).to eq(meal_today.date_of.to_s)
      expect(response_body[1]["food"]).to eq(meal_yesterday.food)
    end

    it 'accepts a limit param which limits the number of meals returned' do
      meal_yesterday = Meal.create(food: "Pizza", date_of: Date.yesterday)
      meal_today = Meal.create(food: "Corndogs", date_of: Date.current)
      get '/api/v1/dinner/recent.json?limit=1'
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body.length).to eq(1)
      expect(response_body[0]["food"]).to eq(meal_today.food)
      expect(response_body[0]["date"]).to eq(meal_today.date_of.to_s)
    end
  end
end
