require 'test_helper'

class ProfileContactDetailsControllerTest < ActionController::TestCase
  setup do
    @profile_contact_detail = profile_contact_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_contact_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_contact_detail" do
    assert_difference('ProfileContactDetail.count') do
      post :create, profile_contact_detail: { address: @profile_contact_detail.address, business_phone: @profile_contact_detail.business_phone, email_address: @profile_contact_detail.email_address, fax: @profile_contact_detail.fax, home_phone: @profile_contact_detail.home_phone, mobile_phone: @profile_contact_detail.mobile_phone }
    end

    assert_redirected_to profile_contact_detail_path(assigns(:profile_contact_detail))
  end

  test "should show profile_contact_detail" do
    get :show, id: @profile_contact_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_contact_detail
    assert_response :success
  end

  test "should update profile_contact_detail" do
    patch :update, id: @profile_contact_detail, profile_contact_detail: { address: @profile_contact_detail.address, business_phone: @profile_contact_detail.business_phone, email_address: @profile_contact_detail.email_address, fax: @profile_contact_detail.fax, home_phone: @profile_contact_detail.home_phone, mobile_phone: @profile_contact_detail.mobile_phone }
    assert_redirected_to profile_contact_detail_path(assigns(:profile_contact_detail))
  end

  test "should destroy profile_contact_detail" do
    assert_difference('ProfileContactDetail.count', -1) do
      delete :destroy, id: @profile_contact_detail
    end

    assert_redirected_to profile_contact_details_path
  end
end
