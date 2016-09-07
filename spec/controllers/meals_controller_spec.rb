require "rails_helper"

RSpec.describe MealsController do
  it "get index is successful" do
    meal = create(:meal)
    get :index
    expect(assigns(:meals)).to include(meal)
    expect(response).to be_success
  end

  it "get show is successful" do
    meal = create(:meal)
    get :show, params: { id: meal.id }
    expect(assigns(:meal)).to eq(meal)
    expect(response).to be_success
  end

  it "get new is successful" do
    get :new
    expect(assigns(:meal)).to be_kind_of(Meal)
    expect(response).to be_success
  end

  it "get edit is successful" do
    meal = create(:meal)
    get :edit, params: { id: meal.id }
    expect(assigns(:meal)).to eq(meal)
    expect(response).to be_success
  end

  it "post create is successful with valid attributes" do
    meal_params = { food: 'Pizza, ice cream cake', date_of: '2016-09-03' }
    expect do
      post :create, params: { meal: meal_params }
    end.to change{Meal.count}.by(1)
    expect(response).to redirect_to(meal_path(Meal.last))
  end

  it "post create is unsuccessful with invalid attributes" do
    invalid_params = { food: '', date_of: '' }
    expect do
      post :create, params: { meal: invalid_params }
    end.to_not change{Meal.count}
    expect(response).to render_template("new")
    expect(response).to be_success
  end

  it "put update is successful with valid attributes" do
    meal = create(:meal)
    valid_attributes = { food: "Peas and cheese" }
    put :update, params: { id: meal.id, meal: valid_attributes }
    expect(meal.reload.food).to eq(valid_attributes[:food])
    expect(response).to redirect_to(meal_path(meal))
  end

  it "put update is unsuccessful with invalid attributes" do
    meal = create(:meal)
    invalid_attributes = { food: '' }
    put :update, params: { id: meal.id, meal: invalid_attributes }
    expect(meal.reload.food).to_not eq(invalid_attributes[:food])
    expect(response).to render_template("edit")
    expect(response).to be_success
  end

  it "delete destroy is successful" do
    meal = create(:meal)
    expect do
      delete :destroy, params: { id: meal.id }
    end.to change{Meal.count}.by(-1)
    expect(response).to redirect_to(meals_path)
  end
end
