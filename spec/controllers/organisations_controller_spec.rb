require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do

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
        post :create, organisation: FactoryGirl.attributes_for(:organisation)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:organisation)
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
      @organisation = FactoryGirl.create(:organisation)
      @response = get :index
    end

    it "populates an array of organisations" do
      expect(assigns(:organisations)).to eq([@organisation])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @organisation = FactoryGirl.create(:organisation)
      @response = get :show, id: @organisation
    end

    it "assigns the requested organisation to @organisation" do
      expect(assigns(:organisation)).to eq(@organisation)
    end
    it "renders the :show template" do
      expect(@response).to render_template :show
    end
  end

  describe "GET #new" do
    login_user :program_coordinator_user

    before :each do
      @response = get :new
    end
    it "assigns a new organisation to @organisation" do
      expect(assigns(:organisation)).to be_a_new(Organisation)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :program_coordinator_user

    context "with valid attributes" do
      it "creates an organisation" do
        expect{
          post :create, organisation: build_attributes(:organisation)
        }.to change(Organisation, :count).by(1)
      end

      it "redirects to organisation#new" do
        post :create, organisation: build_attributes(:organisation)
        expect(response).to redirect_to Organisation.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new organisation in the database" do
        expect{
          post :create, organisation: FactoryGirl.attributes_for(:organisation, name: nil)
        }.to_not change(Organisation,:count)
      end
      it "re-renders the :new template" do
        post :create, organisation: FactoryGirl.attributes_for(:organisation, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :program_coordinator_user

    before :each do
      @organisation = FactoryGirl.create(:organisation, name: 'organisation 1', address: 'address 1',
                                         postal_address: 'postal address 1',
                                         country: FactoryGirl.create(:country, name:'Country 1'),
                                         telephones: 'telephone 1',
                                         email_address: 'address1@address1.com', website: 'www.website1.com')
    end

    context "valid attributes" do
      it "locates the requested @organisation" do
        put :update, id: @organisation, organisation: FactoryGirl.attributes_for(:organisation)
        expect(assigns(:organisation)).to eq(@organisation)
      end

      it "changes @organisation's attributes" do
        put :update, id: @organisation,
            organisation: FactoryGirl.attributes_for(:organisation, name: 'organisation 2', address: 'address 2',
                                             postal_address: 'postal address 2',
                                             telephones: 'telephone 2',
                                             email_address: 'address2@address1.com', website: 'www.website2.com')
        @organisation.reload
        expect(@organisation.name).to eq("organisation 2")
        expect(@organisation.address).to eq("address 2")
        expect(@organisation.postal_address).to eq("postal address 2")
        expect(@organisation.telephones).to eq("telephone 2")
        expect(@organisation.email_address).to eq("address2@address1.com")
        expect(@organisation.website).to eq("www.website2.com")
      end

      it "redirects to the updated organisation" do
        put :update, id: @organisation, organisation: FactoryGirl.attributes_for(:organisation)
        expect(response).to redirect_to @organisation
      end
    end

    context "invalid attributes" do
      it "locates the requested @organisation" do
        put :update, id: @organisation, organisation: FactoryGirl.attributes_for(:organisation, name: nil)
        expect(assigns(:organisation)).to eq(@organisation)
      end

      it "does not change @organisation's attributes" do
        put :update, id: @organisation,
            organisation: FactoryGirl.attributes_for(:organisation, name: nil)
        @organisation.reload
        expect(@organisation.name).to eq("organisation 1")
        expect(@organisation.address).to eq("address 1")
        expect(@organisation.postal_address).to eq("postal address 1")
        expect(@organisation.telephones).to eq("telephone 1")
        expect(@organisation.email_address).to eq("address1@address1.com")
        expect(@organisation.website).to eq("www.website1.com")
      end

      it "re-renders the edit method" do
        put :update, id: @organisation, organisation: FactoryGirl.attributes_for(:organisation, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :program_coordinator_user

    before :each do
      @organisation = FactoryGirl.create(:organisation)
    end

    it "deletes an organisation" do
      expect{
        delete :destroy, :id => @organisation
      }.to change(Organisation, :count).by(-1)
    end

    it "redirects to organisations#index" do
      delete :destroy, :id => @organisation
      expect(response).to redirect_to organisations_url
    end
  end

end
