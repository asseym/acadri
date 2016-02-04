require 'rails_helper'

RSpec.describe "AccountsInvoices", type: :request do
  describe "GET /accounts_invoices" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get accounts_invoices_path
      expect(response).to have_http_status(200)
    end
  end
end
