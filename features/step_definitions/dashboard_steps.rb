def create_user_for_current_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

Given(/^I exist as a "([^"]*)"$/) do |factory|
  create_visitor factory
  create_user_for_current_visitor
end

Given(/^I exist as a "([^"]*)" with name "([^"]*)"$/) do |factory, name|
  create_visitor factory
  @visitor[:name] = name
  create_user_for_current_visitor
end

Then(/^I should see the header "([^"]*)"$/) do |header|
  within 'h1' do
    expect(page).to have_content header
  end
end

Then(/^I should see a sub\-header "([^"]*)"$/) do |sub_header|
  within 'small#page-title-sub-header' do
    expect(page).to have_content sub_header
  end
end