module Dinner
  class API < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    prefix :api

    namespace :dinner, desc: "Info about recent dinners" do
      desc "Return today's meal."
      get :today do
        Meal.where(date_of: Date.current)
      end

      desc "Return recent meals."
      params do
        optional :limit, type: Integer, default: 5,
          values: [1, 2, 3, 4, 5], desc: "Number of meals (up to 5)"
      end
      get :recent do
        Meal.recent.limit(params[:limit] || 5)
      end
    end

    add_swagger_documentation info: {
        title: "Dinner API",
        description: "Get information about Alex's recent meals.",
        contact_name: "Alex Howington"
      }
  end
end
