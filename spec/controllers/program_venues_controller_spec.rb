require 'rails_helper'

RSpec.describe ProgramVenuesController, type: :controller do

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
        post :create, program_venue: FactoryGirl.attributes_for(:program_venue)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:program_venue)
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
      @program_venue = FactoryGirl.create(:program_venue)
      @response = get :index
    end

    it "populates an array of program_venues" do
      expect(assigns(:program_venues)).to eq([@program_venue])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @program_venue = FactoryGirl.create(:program_venue)
      @response = get :show, id: @program_venue
    end

    it "assigns the requested program_venue to @program_venue" do
      expect(assigns(:program_venue)).to eq(@program_venue)
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
    it "assigns a new program_venue to @program_venue" do
      expect(assigns(:program_venue)).to be_a_new(ProgramVenue)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :program_coordinator_user

    context "with valid attributes" do
      it "creates an program_venue" do
        expect{
          post :create, program_venue: build_attributes(:program_venue)
        }.to change(ProgramVenue, :count).by(1)
      end

      it "redirects to program_venue#new" do
        post :create, program_venue: build_attributes(:program_venue)
        expect(response).to redirect_to ProgramVenue.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new program_venue in the database" do
        expect{
          post :create, program_venue: FactoryGirl.attributes_for(:program_venue, name: nil)
        }.to_not change(ProgramVenue,:count)
      end
      it "re-renders the :new template" do
        post :create, program_venue: FactoryGirl.attributes_for(:program_venue, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :program_coordinator_user

    before :each do
      @program_venue = FactoryGirl.create(:program_venue, name: 'place 1')
    end

    context "valid attributes" do
      it "locates the requested @program_venue" do
        put :update, id: @program_venue, program_venue: FactoryGirl.attributes_for(:program_venue)
        expect(assigns(:program_venue)).to eq(@program_venue)
      end

      it "changes @program_venue's attributes" do
        put :update, id: @program_venue,
            program_venue: FactoryGirl.attributes_for(:program_venue, name: 'place 2')
        @program_venue.reload
        expect(@program_venue.name).to eq('place 2')
      end

      it "redirects to the updated program_venue" do
        put :update, id: @program_venue, program_venue: FactoryGirl.attributes_for(:program_venue)
        expect(response).to redirect_to @program_venue
      end
    end

    context "invalid attributes" do
      it "locates the requested @program_venue" do
        put :update, id: @program_venue, program_venue: FactoryGirl.attributes_for(:program_venue, name: nil)
        expect(assigns(:program_venue)).to eq(@program_venue)
      end

      it "does not change @program_venue's attributes" do
        put :update, id: @program_venue,
            program_venue: FactoryGirl.attributes_for(:program_venue, name: nil)
        @program_venue.reload
        expect(@program_venue.name).to eq('place 1')
      end

      it "re-renders the edit method" do
        put :update, id: @program_venue, program_venue: FactoryGirl.attributes_for(:program_venue, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :program_coordinator_user

    before :each do
      @program_venue = FactoryGirl.create(:program_venue)
    end

    it "deletes an program_venue" do
      expect{
        delete :destroy, :id => @program_venue
      }.to change(ProgramVenue, :count).by(-1)
    end

    it "redirects to program_venues#index" do
      delete :destroy, :id => @program_venue
      expect(response).to redirect_to program_venues_url
    end
  end

end
