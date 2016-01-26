require 'rails_helper'

RSpec.describe CountriesController, type: :controller do

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
        post :create, country: FactoryGirl.attributes_for(:country)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:country)
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
      @country = FactoryGirl.create(:country)
      @response = get :index
    end

    it "populates an array of countries" do
      expect(assigns(:countries)).to eq([@country])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @country = FactoryGirl.create(:country)
      @response = get :show, id: @country
    end

    it "assigns the requested country to @country" do
      expect(assigns(:country)).to eq(@country)
    end
    it "renders the :show template" do
      expect(@response).to render_template :show
    end
  end

  describe "GET #new" do
    login_user :admin_user

    before :each do
      @response = get :new
    end
    it "assigns a new country to @country" do
      expect(assigns(:country)).to be_a_new(Country)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :admin_user

    context "with valid attributes" do
      it "creates an country" do
        expect{
          post :create, country: FactoryGirl.attributes_for(:country)
        }.to change(Country, :count).by(1)
      end

      it "redirects to country#new" do
        post :create, country: FactoryGirl.attributes_for(:country)
        expect(response).to redirect_to Country.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new country in the database" do
        expect{
          post :create, country: FactoryGirl.attributes_for(:country, name: nil)
        }.to_not change(Country,:count)
      end
      it "re-renders the :new template" do
        post :create, country: FactoryGirl.attributes_for(:country, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :admin_user

    before :each do
      @country = FactoryGirl.create(:country, name: 'country 1', c_code: 'C1', telephone_code: 256)
    end

    context "valid attributes" do
      it "locates the requested @country" do
        put :update, id: @country, country: FactoryGirl.attributes_for(:country)
        expect(assigns(:country)).to eq(@country)
      end

      it "changes @country's attributes" do
        put :update, id: @country,
            country: FactoryGirl.attributes_for(:country, name: "country 2", c_code: 'C2', telephone_code: 254)
        @country.reload
        expect(@country.name).to eq("country 2")
        expect(@country.c_code).to eq("C2")
        expect(@country.telephone_code).to eq(254)
      end

      it "redirects to the updated country" do
        put :update, id: @country, country: FactoryGirl.attributes_for(:country)
        expect(response).to redirect_to @country
      end
    end

    context "invalid attributes" do
      it "locates the requested @country" do
        put :update, id: @country, country: FactoryGirl.attributes_for(:country, name: nil)
        expect(assigns(:country)).to eq(@country)
      end

      it "does not change @country's attributes" do
        put :update, id: @country,
            country: FactoryGirl.attributes_for(:country, name: nil)
        @country.reload
        expect(@country.name).to eq("country 1")
        expect(@country.c_code).to eq("C1")
        expect(@country.telephone_code).to eq(256)
      end

      it "re-renders the edit method" do
        put :update, id: @country, country: FactoryGirl.attributes_for(:country, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :admin_user

    before :each do
      @country = FactoryGirl.create(:country)
    end

    it "deletes an country" do
      expect{
        delete :destroy, :id => @country
      }.to change(Country, :count).by(-1)
    end

    it "redirects to countrys#index" do
      delete :destroy, :id => @country
      expect(response).to redirect_to countries_url
    end
  end
end
