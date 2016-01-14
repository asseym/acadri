require 'test_helper'

class UserNotificationsControllerTest < ActionController::TestCase
  setup do
    @user_notification = user_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_notifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_notification" do
    assert_difference('UserNotification.count') do
      post :create, user_notification: { notification_id: @user_notification.notification_id, resolved: @user_notification.resolved, user_id: @user_notification.user_id }
    end

    assert_redirected_to user_notification_path(assigns(:user_notification))
  end

  test "should show user_notification" do
    get :show, id: @user_notification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_notification
    assert_response :success
  end

  test "should update user_notification" do
    patch :update, id: @user_notification, user_notification: { notification_id: @user_notification.notification_id, resolved: @user_notification.resolved, user_id: @user_notification.user_id }
    assert_redirected_to user_notification_path(assigns(:user_notification))
  end

  test "should destroy user_notification" do
    assert_difference('UserNotification.count', -1) do
      delete :destroy, id: @user_notification
    end

    assert_redirected_to user_notifications_path
  end
end
