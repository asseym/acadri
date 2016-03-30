Given(/^(\d+) "([^"]*)" exist in the database$/) do |x, factory_name|
  if x.to_i == 0
    klass = factory_name.classify.constantize
    klass.delete_all
  else
    @data = Array.new
    x.to_i.times do
      @data << FactoryGirl.create(factory_name)
    end
  end
end

Given(/^(\d+) "([^"]*)" exists in the database$/) do |x, factory_name|
  @data = Array.new
  x.to_i.times do
    @data << FactoryGirl.create(factory_name)
  end
end

When(/^I click on the "([^"]*)" menu$/) do |link|
  page.find("##{link.downcase}-btn").click
end

When(/^I click on the "([^"]*)" button$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click on the "([^"]*)" link$/) do |url|
  # page.find(:linkhref, url).click
  page.find(:xpath, "//a[@href='#{url}']").click
  # page.find("a[href='#{url}']").click
end

When(/^I click on the "([^"]*)" link with "([^"]*)" style$/) do |link_name, class_name|
  style = class_name.to_s.gsub!(" ", ".")
  find(".#{style}", :text => link_name).click
end

When(/^I click on the "([^"]*)" breadcrumb$/) do |bcrumb_name|
  within 'ul.breadcrumb' do
    click_on bcrumb_name
  end
end

Then(/^I should see a list of account invoices$/) do
  @data.each do |dt|
    within 'table.table.table-hover' do
      expect(page).to have_content dt.training.title
      expect(page).to have_content dt.invoice_number_string
      expect(page).to have_content dt.invoice_date
      expect(page).to have_content dt.invoice_terms
    end
  end
end

When(/^I click on the first invoice training title$/) do
  page.find("#js_accounts_invoice_#{@data[0].id}").click
end

Then(/^I should see the invoice$/) do
  expect(page).to have_content @data[0].invoice_number_string
  expect(page).to have_content 'ACADRI'
  expect(page).to have_content 'INVOICE'
end

Then(/^I should see an "([^"]*)" create form$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I fill in the following information$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the new invoice (\d+) created$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end