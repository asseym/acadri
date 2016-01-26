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

  describe "access control: PRIVILAGES" do
    login_user nil

    it "requires sufficient privilages to create" do
      expect{
        post :create, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:accounts_invoice_item)
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
      @accounts_invoice_item = FactoryGirl.create(:accounts_invoice_item)
      @response = get :index
    end

    it "populates an array of accounts_invoices" do
      expect(assigns(:accounts_invoice_items)).to eq([@accounts_invoice_item])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @accounts_invoice_item = FactoryGirl.create(:accounts_invoice_item)
      @response = get :show, id: @accounts_invoice_item
    end

    it "assigns the requested invoice to @accounts_invoice" do
      expect(assigns(:accounts_invoice_item)).to eq(@accounts_invoice_item)
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
      expect(assigns(:accounts_invoice_item)).to be_a_new(AccountsInvoiceItem)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :finance_user

    context "with valid attributes" do
      it "creates an invoice item" do
        expect{
          post :create, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item)
        }.to change(AccountsInvoiceItem, :count).by(1)
      end

      it "redirects to invoice item#new" do
        post :create, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item)
        expect(response).to redirect_to AccountsInvoiceItem.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new invoice item in the database" do
        expect{
          post :create, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item, units: 'bad-units')
        }.to_not change(AccountsInvoiceItem,:count)
      end
      it "re-renders the :new template" do
        post :create, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item, units: 'bad-units')
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :finance_user

    before :each do
      @accounts_invoice_item = FactoryGirl.create(:accounts_invoice_item, description: 'x description', units: 2, unit_cost: 5)
    end

    context "valid attributes" do
      it "locates the requested @accounts_invoice_item" do
        put :update, id: @accounts_invoice_item, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item)
        expect(assigns(:accounts_invoice_item)).to eq(@accounts_invoice_item)
      end

      it "changes @accounts_invoice's attributes" do
        put :update, id: @accounts_invoice_item,
            accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item, description: "y description", units: 1, unit_cost: 3)
        @accounts_invoice_item.reload
        expect(@accounts_invoice_item.description).to eq("y description")
        expect(@accounts_invoice_item.units).to eq(1)
        expect(@accounts_invoice_item.unit_cost).to eq(3)
      end

      it "redirects to the updated accounts_invoice_item" do
        put :update, id: @accounts_invoice_item, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item)
        expect(response).to redirect_to @accounts_invoice_item
      end
    end

    context "invalid attributes" do
      it "locates the requested @accounts_invoice_item" do
        put :update, id: @accounts_invoice_item, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item, units: 'bad-units')
        expect(assigns(:accounts_invoice_item)).to eq(@accounts_invoice_item)
      end

      it "does not change @accounts_invoice_item's attributes" do
        put :update, id: @accounts_invoice_item,
            accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item, units: 'bad-units')
        @accounts_invoice_item.reload
        expect(@accounts_invoice_item.description).to eq("x description")
        expect(@accounts_invoice_item.units).to eq(2)
        expect(@accounts_invoice_item.unit_cost).to eq(5)
      end

      it "re-renders the edit method" do
        put :update, id: @accounts_invoice_item, accounts_invoice_item: FactoryGirl.attributes_for(:accounts_invoice_item, units: 'bad-units')
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do

    login_user :finance_user

    before :each do
      @invoice_item = FactoryGirl.create(:accounts_invoice_item)
    end

    it "deletes an invoice item" do
      expect{
        delete :destroy, :id => @invoice_item
      }.to change(AccountsInvoiceItem, :count).by(-1)
    end

    it "redirects to invoice items#index" do
      delete :destroy, :id => @invoice_item
      expect(response).to redirect_to accounts_invoice_items_url
    end
  end

end
