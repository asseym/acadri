require 'rails_helper'

RSpec.describe "ProgramVenues", type: :request do
  describe "GET /program_venues" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get program_venues_path
      expect(response).to have_http_status(200)
    end
  end
end
