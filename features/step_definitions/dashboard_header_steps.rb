Then(/^I do not see a page header$/) do
  expect(page).to_not have_css 'div.page-header'
end

Then(/^I see a page header$/) do
  expect(page).to have_css 'div.page-header'
end

Then(/^I see a page logo in the header$/) do
  within 'div.page-logo' do
    expect(page).to have_selector("img[id='logo']")
  end
end

Then(/^I see a menu toggler in the header$/) do
  within 'div.page-logo' do
    expect(page).to have_css 'div.menu-toggler'
  end
end

Then(/^I see a search button in the header$/) do
  within 'div.page-top' do
    expect(page).to have_selector("form[class='search-form']")
  end
end

Then(/^I see a notification panel in the header$/) do
  within 'div.top-menu' do
    expect(page).to have_selector("li[id='header_notification_bar']")
  end
end

Then(/^I see a messages panel in the header$/) do
  within 'div.top-menu' do
    expect(page).to have_selector("li[id='header_inbox_bar']")
  end
end

Then(/^I see a tasks panel in the header$/) do
  within 'div.top-menu' do
    expect(page).to have_selector("li[id='header_task_bar']")
  end
end

Then(/^I see my name "([^"]*)" in the header$/) do |name|
  within 'span.username' do
    expect(page).to have_content name
  end
end

When(/^I click the page logo$/) do
  find("img[id='logo']").click
end

Then(/^I am directed to the dashboard$/) do
  expect(current_path).to match '/'
  within 'h1' do
    expect(page).to have_content 'Dashboard'
  end
end

When(/^I click the search magnifier icon$/) do
  find("#system-search").click
end

Then(/^I see a search form with a "([^"]*)" placeholder$/) do |placeholder|
  within "form.search-form" do
    expect(page).to have_selector("input[id='query']")
  end
end

Then(/^I can type in the search form "([^"]*)"$/) do |search_term|
  fill_in "query", with: search_term
end

When(/^I type in the search form "([^"]*)"$/) do |search_term|
  fill_in "query", with: search_term
end

Then(/^I see the search term "([^"]*)"$/) do |search_term|
  expect(page).to have_content search_term
end

Then(/^I see a search results page$/) do
  within 'h1' do
    expect(page).to have_content 'Search Results'
  end
end

Then(/^I see a "([^"]*)" title$/) do |arg1|
  within 'div.title' do
    expect(page).to have_content 'Results Not Found'
  end
end

When(/^I click the search link$/) do
  find('#search-btn').click
end
Given(/^I have a notifaction "([^"]*)"$/) do |notification|
  @user.notify(notification)
end

When(/^I click the notification panel$/) do
  find("#notification-notifier").click
end

Then(/^I see a list of my notifications including "([^"]*)"$/) do |notification|
  within 'li#header_notification_bar' do
    expect(page).to have_content notification
  end
end

When(/^I click on a notification$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I am directed to my dashboard$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
