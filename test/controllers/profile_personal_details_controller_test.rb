require 'test_helper'

class ProfilePersonalDetailsControllerTest < ActionController::TestCase
  setup do
    @profile_personal_detail = profile_personal_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_personal_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_personal_detail" do
    assert_difference('ProfilePersonalDetail.count') do
      post :create, profile_personal_detail: { birthday: @profile_personal_detail.birthday, first_name: @profile_personal_detail.first_name, languages: @profile_personal_detail.languages, marital_status: @profile_personal_detail.marital_status, nationality: @profile_personal_detail.nationality, other_names: @profile_personal_detail.other_names, religion: @profile_personal_detail.religion, sex: @profile_personal_detail.sex }
    end

    assert_redirected_to profile_personal_detail_path(assigns(:profile_personal_detail))
  end

  test "should show profile_personal_detail" do
    get :show, id: @profile_personal_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_personal_detail
    assert_response :success
  end

  test "should update profile_personal_detail" do
    patch :update, id: @profile_personal_detail, profile_personal_detail: { birthday: @profile_personal_detail.birthday, first_name: @profile_personal_detail.first_name, languages: @profile_personal_detail.languages, marital_status: @profile_personal_detail.marital_status, nationality: @profile_personal_detail.nationality, other_names: @profile_personal_detail.other_names, religion: @profile_personal_detail.religion, sex: @profile_personal_detail.sex }
    assert_redirected_to profile_personal_detail_path(assigns(:profile_personal_detail))
  end

  test "should destroy profile_personal_detail" do
    assert_difference('ProfilePersonalDetail.count', -1) do
      delete :destroy, id: @profile_personal_detail
    end

    assert_redirected_to profile_personal_details_path
  end
end
