require 'rails_helper'

RSpec.describe AccountsInvoiceItemsController, type: :controller do

  describe "access control" do

    it "requires login for create" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end

    it "requires login for destroy" do
      delete :destroy, :id => 1
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
