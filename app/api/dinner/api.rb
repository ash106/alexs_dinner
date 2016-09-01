module Dinner
  class API < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    prefix :api

    desc "Return today's meal."
    get :today do
      Meal.where(date_of: Date.today)
    end

    desc "Return recent meals."
    get :recent do
      Meal.recent.limit(params[:limit] || 5)
    end
  end
end
