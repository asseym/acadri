require 'rails_helper'

RSpec.describe "Rfqs", type: :request do
  describe "GET /rfqs" do
    it "works! (now write some real specs)" do
      get rfqs_path
      expect(response).to have_http_status(200)
    end
  end
end
