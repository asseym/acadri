require 'rails_helper'

RSpec.describe "ProfileContactDetails", type: :request do
  describe "GET /profile_contact_details" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get profile_contact_details_path
      expect(response).to have_http_status(200)
    end
  end
end
