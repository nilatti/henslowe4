require 'test_helper'

class SpacesControllerTest < ActionController::TestCase
  setup do
    @space = spaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create space" do
    assert_difference('Space.count') do
      post :create, space: { calendar: @space.calendar, city: @space.city, name: @space.name, phone_number: @space.phone_number, seating_capacity: @space.seating_capacity, state: @space.state, street_address: @space.street_address, theater_id: @space.theater_id, website: @space.website, zip: @space.zip }
    end

    assert_redirected_to space_path(assigns(:space))
  end

  test "should show space" do
    get :show, id: @space
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @space
    assert_response :success
  end

  test "should update space" do
    patch :update, id: @space, space: { calendar: @space.calendar, city: @space.city, name: @space.name, phone_number: @space.phone_number, seating_capacity: @space.seating_capacity, state: @space.state, street_address: @space.street_address, theater_id: @space.theater_id, website: @space.website, zip: @space.zip }
    assert_redirected_to space_path(assigns(:space))
  end

  test "should destroy space" do
    assert_difference('Space.count', -1) do
      delete :destroy, id: @space
    end

    assert_redirected_to spaces_path
  end
end
