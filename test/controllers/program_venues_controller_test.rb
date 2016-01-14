require 'test_helper'

class ProgramVenuesControllerTest < ActionController::TestCase
  setup do
    @program_venue = program_venues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_venues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_venue" do
    assert_difference('ProgramVenue.count') do
      post :create, program_venue: { country_id: @program_venue.country_id, name: @program_venue.name }
    end

    assert_redirected_to program_venue_path(assigns(:program_venue))
  end

  test "should show program_venue" do
    get :show, id: @program_venue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_venue
    assert_response :success
  end

  test "should update program_venue" do
    patch :update, id: @program_venue, program_venue: { country_id: @program_venue.country_id, name: @program_venue.name }
    assert_redirected_to program_venue_path(assigns(:program_venue))
  end

  test "should destroy program_venue" do
    assert_difference('ProgramVenue.count', -1) do
      delete :destroy, id: @program_venue
    end

    assert_redirected_to program_venues_path
  end
end
