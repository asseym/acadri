require 'test_helper'

class ProfileBankDetailsControllerTest < ActionController::TestCase
  setup do
    @profile_bank_detail = profile_bank_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_bank_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_bank_detail" do
    assert_difference('ProfileBankDetail.count') do
      post :create, profile_bank_detail: { bank_details: @profile_bank_detail.bank_details }
    end

    assert_redirected_to profile_bank_detail_path(assigns(:profile_bank_detail))
  end

  test "should show profile_bank_detail" do
    get :show, id: @profile_bank_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_bank_detail
    assert_response :success
  end

  test "should update profile_bank_detail" do
    patch :update, id: @profile_bank_detail, profile_bank_detail: { bank_details: @profile_bank_detail.bank_details }
    assert_redirected_to profile_bank_detail_path(assigns(:profile_bank_detail))
  end

  test "should destroy profile_bank_detail" do
    assert_difference('ProfileBankDetail.count', -1) do
      delete :destroy, id: @profile_bank_detail
    end

    assert_redirected_to profile_bank_details_path
  end
end
