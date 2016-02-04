require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  feature "Display Front Page" do
    given(:user) { FactoryGirl.create(:staff_user) }
    background :each do
      login_as(user)
      visit root_path
    end

    scenario "Properly Displays a Standard Header" do
      expect(page).to have_selector('div.page-header')
      within('div.page-header') do
        expect(page).to have_selector('div.page-logo')
        expect(page).to have_selector('i.icon-magnifier')
        expect(page).to have_selector('i.icon-bell')
        expect(page).to have_selector('span.badge-success')
        expect(page).to have_selector('i.icon-envelope-open')
        expect(page).to have_selector('span.badge-danger')
        expect(page).to have_selector('i.icon-calendar')
        expect(page).to have_selector('span.badge-primary')
        expect(page).to have_content user.name
      end
    end

    scenario "All Header Elements Work When Clicked" do
      within('div.page-header') do
        find("img[alt='logo']").click
        expect(page).to have_current_path(root_path)
      end
    end
    scenario "Displays Navigation"
    scenario "Properly Displays Breadcrumbs"
    scenario "Properly Displays Statistics/Page Body"
    scenario "Properly Displays Footer"
  end
end
