### UTILITY METHODS ###

def create_visitor (user_factory=false)
  user_factory = :user if user_factory == false
  @visitor ||= FactoryGirl.attributes_for(user_factory)
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor :superadmin
  sign_in
  create_visitor :unconfirmed_user
  create_staff_account
  visit destroy_user_session_path
end

def create_staff_account
  visit new_user_path
  fill_in "name", :with => @visitor[:name]
  fill_in "email", :with => @visitor[:email]
  fill_in "password", :with => @visitor[:password]
  fill_in "password_confirmation", :with => @visitor[:password_confirmation]
  select  "staff", :from => :roles
  click_button "Create"
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def create_superadmin_user
  create_visitor :superadmin
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_in
  visit new_user_session_path
  fill_in "login-email",    with: @visitor[:email], match: :first
  fill_in "login-password", with: @visitor[:password], match: :first
  click_button "login-btn"
end

def sign_out
  visit destroy_user_session_path
end

### GIVEN ###
Given /^I exist as a user$/ do
  create_user
end

Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When(/^I sign in with valid credentials$/) do
  sign_in
end

When /^I sign in with invalid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  # visit destroy_user_session_path
  sign_out
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit users_path
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Log out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  expect(page).to have_content "Sign In"
  expect(page).to have_button "Login"
  expect(page).to_not have_content "Log out"
  # expect(page).to_not have_link('Log out', href: destroy_session_path(user))
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I see a successful sign in message$/ do
  expect(page).to have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  expect(page).to have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end