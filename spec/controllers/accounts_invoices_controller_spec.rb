require 'rails_helper'

RSpec.describe AccountsInvoicesController, type: :controller do

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

  describe "access control: PRIVILAGES" do
    login_user nil

    it "requires sufficient privilages to create" do
      expect{
        post :create, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:accounts_invoice)
      }.to raise_error(CanCan::AccessDenied)
    end

  end

  describe "knows current user" do

    login_user :admin_user

    it "has a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "knows role of current user" do
      expect(subject.current_user.roles).to match [:admin]
    end

  end

  describe "POST 'create'" do

    login_user :finance_user

    it "creates an invoice" do
      expect{
        # post :create, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice)
        post :create, accounts_invoice: build_attributes(:accounts_invoice, "invoice_number")
      }.to change(AccountsInvoice, :count).by(1)
    end

    it "redirects to invoice#new" do
      post :create, accounts_invoice: build_attributes(:accounts_invoice, "invoice_number")
      expect(response).to redirect_to AccountsInvoice.last
    end

  end

  describe "DELETE 'destroy'" do

    login_user :finance_user

    before :each do
      @invoice = FactoryGirl.create(:accounts_invoice)
    end

    it "deletes an invoice" do
      expect{
        delete :destroy, :id => @invoice
      }.to change(AccountsInvoice, :count).by(-1)
    end

    it "redirects to invoices#index" do
      delete :destroy, :id => @invoice
      expect(response).to redirect_to accounts_invoices_url
    end

  end

end
