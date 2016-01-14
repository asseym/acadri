require 'test_helper'

class ProfileGeneralDetailsControllerTest < ActionController::TestCase
  setup do
    @profile_general_detail = profile_general_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_general_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_general_detail" do
    assert_difference('ProfileGeneralDetail.count') do
      post :create, profile_general_detail: { NSSF_number: @profile_general_detail.NSSF_number, date_hired: @profile_general_detail.date_hired, drivers_licence: @profile_general_detail.drivers_licence, education: @profile_general_detail.education, passport_number: @profile_general_detail.passport_number, salary: @profile_general_detail.salary, staff_id: @profile_general_detail.staff_id }
    end

    assert_redirected_to profile_general_detail_path(assigns(:profile_general_detail))
  end

  test "should show profile_general_detail" do
    get :show, id: @profile_general_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_general_detail
    assert_response :success
  end

  test "should update profile_general_detail" do
    patch :update, id: @profile_general_detail, profile_general_detail: { NSSF_number: @profile_general_detail.NSSF_number, date_hired: @profile_general_detail.date_hired, drivers_licence: @profile_general_detail.drivers_licence, education: @profile_general_detail.education, passport_number: @profile_general_detail.passport_number, salary: @profile_general_detail.salary, staff_id: @profile_general_detail.staff_id }
    assert_redirected_to profile_general_detail_path(assigns(:profile_general_detail))
  end

  test "should destroy profile_general_detail" do
    assert_difference('ProfileGeneralDetail.count', -1) do
      delete :destroy, id: @profile_general_detail
    end

    assert_redirected_to profile_general_details_path
  end
end
