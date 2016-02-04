require 'rails_helper'

RSpec.describe "ProfilePersonalDetails", type: :request do
  describe "GET /profile_personal_details" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get profile_personal_details_path
      expect(response).to have_http_status(200)
    end
  end
end
