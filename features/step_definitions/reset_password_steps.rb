Given(/^I exist as a user with email address "([^"]*)"$/) do |email|
  @visitor = FactoryGirl.attributes_for(:staff_user)
  @visitor[:email] = email
  @user = FactoryGirl.create(:user, @visitor)
end

When(/^I click the Forgot Password\? link$/) do
  click_link "Forgot Password?"
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |pass_email_field, email_address|
  fill_in pass_email_field, with: email_address
end

When(/^I click "([^"]*)"$/) do |forgot_btn|
  click_button forgot_btn
end

When(/^I receive (\d+) password reset email at "([^"]*)"$/) do |amount, email_address|
  expect(unread_emails_for(email_address).size).to eql parse_email_count(amount)
end

Then(/^I should see "([^"]*)"$/) do |reset_password_header|
  within 'h2' do
    expect(page).to have_content reset_password_header
  end
end

When(/^When I submit my new password details$/) do
  fill_in "pass_reset", with: "newpassw0rd!"
  fill_in "pass_reset_confirmation", with: "newpassw0rd!"
  click_button "Change my password"
end

When(/^I login with the new password$/) do
  visit new_user_session_path
  fill_in "login-email",    with: @visitor[:email], match: :first
  fill_in "login-password", with: "newpassw0rd!", match: :first
  click_button "login-btn"
end
