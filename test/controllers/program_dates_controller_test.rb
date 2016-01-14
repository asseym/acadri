require 'test_helper'

class ProgramDatesControllerTest < ActionController::TestCase
  setup do
    @program_date = program_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_date" do
    assert_difference('ProgramDate.count') do
      post :create, program_date: { date: @program_date.date }
    end

    assert_redirected_to program_date_path(assigns(:program_date))
  end

  test "should show program_date" do
    get :show, id: @program_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_date
    assert_response :success
  end

  test "should update program_date" do
    patch :update, id: @program_date, program_date: { date: @program_date.date }
    assert_redirected_to program_date_path(assigns(:program_date))
  end

  test "should destroy program_date" do
    assert_difference('ProgramDate.count', -1) do
      delete :destroy, id: @program_date
    end

    assert_redirected_to program_dates_path
  end
end
