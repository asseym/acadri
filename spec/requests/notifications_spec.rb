require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "GET /notifications" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get notifications_path
      expect(response).to have_http_status(200)
    end
  end
end
