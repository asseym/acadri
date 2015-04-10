require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:testuser)
    @other_user = users(:testuser2)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should not access other users profiles" do
    log_in_as(@user)
    get :edit, id: @other_user
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should not update other users information" do
    log_in_as(@user)
    patch :update, id: @other_user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  test "should not be possible to update user admin parameter on open web" do
    log_in_as(@other_user)
    patch :update, id: @other_user, user: { admin: true }
    @other_user.reload
    assert_not @other_user.admin, true
  end
  
  test "should not be possible to delete user when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @other_user
    end
    assert_redirected_to login_url
  end
  
  test "should not be able to delete users when not admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
    
  
end
