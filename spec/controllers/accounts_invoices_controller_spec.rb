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

  describe "GET #index" do
    login_user :staff_user

    before :each do
      @accounts_invoice = FactoryGirl.create(:accounts_invoice)
      @response = get :index
    end

    it "populates an array of accounts_invoices" do
      expect(assigns(:accounts_invoices)).to eq([@accounts_invoice])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @accounts_invoice = FactoryGirl.create(:accounts_invoice)
      @response = get :show, id: @accounts_invoice
    end

    it "assigns the requested invoice to @accounts_invoice" do
      expect(assigns(:accounts_invoice)).to eq(@accounts_invoice)
    end
    it "renders the :show template" do
      expect(@response).to render_template :show
    end
  end

  describe "GET #new" do
    login_user :finance_user

    before :each do
      @response = get :new
    end
    it "assigns a new AccountsInvoice to @accounts_invoice" do
      expect(assigns(:accounts_invoice)).to be_a_new(AccountsInvoice)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :finance_user

    context "with valid attributes" do
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

    context "with invalid attributes" do
      it "does not save the new invoice in the database" do
        expect{
          post :create, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice, invoice_date: 'bad-date')
        }.to_not change(AccountsInvoice,:count)
      end
      it "re-renders the :new template" do
        post :create, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice, invoice_date: 'bad-date')
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :finance_user

    before :each do
      @accounts_invoice = FactoryGirl.create(:accounts_invoice, invoice_date: Date.today, invoice_terms: "terms 1, 2, 3", currency: "USD")
    end

    context "valid attributes" do
      it "locates the requested @accounts_invoice" do
        put :update, id: @accounts_invoice, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice)
        expect(assigns(:accounts_invoice)).to eq(@accounts_invoice)
      end

      it "changes @accounts_invoice's attributes" do
        put :update, id: @accounts_invoice,
            accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice, invoice_terms: "terms 3, 2, 1", currency: "UGX")
        @accounts_invoice.reload
        expect(@accounts_invoice.invoice_terms).to eq("terms 3, 2, 1")
        expect(@accounts_invoice.currency).to eq("UGX")
      end

      it "redirects to the updated accounts_invoice" do
        put :update, id: @accounts_invoice, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice)
        expect(response).to redirect_to @accounts_invoice
      end
    end

    context "invalid attributes" do
      it "locates the requested @accounts_invoice" do
        put :update, id: @accounts_invoice, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice, invoice_date: 'bad-date')
        expect(assigns(:accounts_invoice)).to eq(@accounts_invoice)
      end

      it "does not change @accounts_invoice's attributes" do
        put :update, id: @accounts_invoice,
            accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice, invoice_date: 'bad-date')
        @accounts_invoice.reload
        expect(@accounts_invoice.invoice_terms).to eq("terms 1, 2, 3")
        expect(@accounts_invoice.currency).to eq("USD")
      end

      it "re-renders the edit method" do
        put :update, id: @accounts_invoice, accounts_invoice: FactoryGirl.attributes_for(:accounts_invoice, invoice_date: 'bad-date')
        expect(response).to render_template :edit
      end
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
