require 'rails_helper'

RSpec.describe "AccountsInvoiceItems", type: :request do
  describe "GET /accounts_invoice_items" do
    login_user :staff_user
    it "works! (now write some real specs)" do
      get accounts_invoice_items_path
      expect(response).to have_http_status(200)
    end
  end
end
