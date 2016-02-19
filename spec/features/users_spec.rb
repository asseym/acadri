require 'rails_helper'

RSpec.feature "Users", type: :feature do
  feature "Login with invalid information" do

    background do
      visit new_user_session_path
    end

    scenario "displays elements of the sign in page" do
      expect(page).to have_selector("h3.form-title", text:"Sign In")
      expect(page).to have_button "Login"
      expect(page).to have_field "user_email"
      expect(page).to have_field "user_password"
      expect(page).to have_selector("a", text: "Forgot Password")
    end

    scenario "does not allow sign in with blank credentials" do
      click_button "Login"
      expect(page).to have_content "Invalid email or password"
    end
  end

  feature "Login with valid ordinary user information" do

    given(:user) { FactoryGirl.create(:ordinary_user) }

    background :each do
      visit new_user_session_path
      fill_in "Email",    with: user.email, match: :first
      fill_in "Password", with: user.password, match: :first
      click_button "Login"
    end

    scenario "shows statistics page" do
      expect(page).to have_selector('h1', text: "Dashboard")
      expect(page).to have_content "dashboard for #{user.name}"
      expect(page).to have_selector('a', text: 'Log out')
      expect(page).to have_selector('a', text: 'Profile')
      expect(page).to have_selector('ul.page-sidebar-menu')
    end
  end

  feature "Login with valid ceo/admin/finance information" do

    given(:user) { FactoryGirl.create(:ceo_user) }

    background :each do
      visit new_user_session_path
      fill_in "Email",    with: user.email, match: :first
      fill_in "Password", with: user.password, match: :first
      click_button "Login"
    end

    scenario "shows statistics page" do
      expect(page).to have_selector('h1', text: "Dashboard")
      expect(page).to have_content 'statistics summary and reports'
      expect(page).to have_selector('a', text: 'Log out')
      expect(page).to have_selector('a', text: 'Profile')
      expect(page).to have_selector('ul.page-sidebar-menu')
    end
  end

  feature "Sign Out" do
    given(:user) { FactoryGirl.create(:ordinary_user) }

    background :each do
      visit new_user_session_path
      fill_in "Email",    with: user.email, match: :first
      fill_in "Password", with: user.password, match: :first
      click_button "Login"
    end

    # scenario "Clicking Log out terminates users session" do
    #   expect{
    #     click_link "Log out"
    #   }.to change { current_user }.from(user).to(nil)
    # end
    scenario "Log out returns to the login page" do
      click_link "Log out"
      expect(page).to have_selector("h3.form-title", text:"Sign In")
      expect(page).to have_button "Login"
      expect(page).to have_field "user_email"
      expect(page).to have_field "user_password"
      expect(page).to have_selector("a", text: "Forgot Password")
      expect(page).to have_selector("div.alert")
      expect(page).to have_content "You need to sign in or sign up before continuing"
    end
  end

  feature "Forgot Password" do
    given(:user) { FactoryGirl.create(:ordinary_user) }

    background :each do
      visit new_user_session_path
    end

    scenario "shows forgot password form", js: true do
      # save_and_open_page
      click_link "Forgot Password?"
      expect(page).to have_selector("h3", text:"Forget Password ?")
      expect(page).to have_content "Enter your e-mail address below to reset your password."
      expect(page).to have_field "forgot-password"
      expect(page).to have_button "Submit"
      expect(page).to have_button "Back"
    end

    scenario "request new password", js: true do
      user.confirm
      click_link "Forgot Password?"
      # find(:css, '#forgot-password').set user.email #make sure to fill forgot pass form to avoid ambiguity
      # fill_in "Email", with: user.email
      fill_in "forgot-password", with: user.email
      # expect{
      #   # click_button "Submit"
      #   # find_button('#forgot-btn').click
      #   click_button 'forgot-btn'
      #   # save_and_open_page
      #   page.find('alert-success', text: 'You will receive an email with instructions on how to reset your password in a few minutes.')
      # }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

  end
end
