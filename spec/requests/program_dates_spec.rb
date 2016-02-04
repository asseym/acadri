require 'rails_helper'

RSpec.describe "ProgramDates", type: :request do
  describe "GET /program_dates" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get program_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
