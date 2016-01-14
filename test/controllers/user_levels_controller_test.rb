require 'test_helper'

class UserLevelsControllerTest < ActionController::TestCase
  setup do
    @user_level = user_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_level" do
    assert_difference('UserLevel.count') do
      post :create, user_level: { name: @user_level.name }
    end

    assert_redirected_to user_level_path(assigns(:user_level))
  end

  test "should show user_level" do
    get :show, id: @user_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_level
    assert_response :success
  end

  test "should update user_level" do
    patch :update, id: @user_level, user_level: { name: @user_level.name }
    assert_redirected_to user_level_path(assigns(:user_level))
  end

  test "should destroy user_level" do
    assert_difference('UserLevel.count', -1) do
      delete :destroy, id: @user_level
    end

    assert_redirected_to user_levels_path
  end
end
