# Alex's Dinner

[![Code Climate](https://codeclimate.com/github/ash106/alexs_dinner/badges/gpa.svg)](https://codeclimate.com/github/ash106/alexs_dinner)

[Alex's Dinner](https://alexsdinner.herokuapp.com/) is a basic CRUD app and API which serves data for the [What Did Alex Eat Today?](https://github.com/ash106/what_did_alex_eat_today) project.

Built using:

- **Rails** for the CRUD app
- **Postgres** as the database
- **Heroku** is hosting the app at [alexsdinner.herokuapp.com](https://alexsdinner.herokuapp.com/)
- **Grape** for the API endpoints
- **Rspec** for tests

These tools just happen to be similar to the stack used at Unsplash. What are the chances?

You can mess around with the data by visiting the [homepage](https://alexsdinner.herokuapp.com/). Try adding a new meal for today or editing an already existing meal, then using the links below to interact with the API.

Useful links:

- [API documentation](http://alexsdinner.herokuapp.com/api/swagger)
- API endpoints: [today](https://alexsdinner.herokuapp.com/api/v1/dinner/today), [recent](https://alexsdinner.herokuapp.com/api/v1/dinner/recent)
- [API ruby code](app/api/dinner/api.rb) (also below)

```ruby
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
```
