require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

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
        post :create, profile: FactoryGirl.attributes_for(:profile)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:profile)
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
      @profile = FactoryGirl.create(:profile)
      @response = get :index
    end

    it "populates an array of profiles" do
      expect(assigns(:profiles)).to eq([@profile])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @profile = FactoryGirl.create(:profile)
      @response = get :show, id: @profile
    end

    it "assigns the requested profile to @profile" do
      expect(assigns(:profile)).to eq(@profile)
    end
    it "renders the :show template" do
      expect(@response).to render_template :show
    end
  end

  describe "GET #new" do
    login_user :manager_user

    before :each do
      @response = get :new
    end
    it "assigns a new profile to @profile" do
      expect(assigns(:profile)).to be_a_new(Profile)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :manager_user

    context "with valid attributes" do
      it "creates an profile" do
        expect{
          post :create, profile: build_attributes(:profile)
        }.to change(Profile, :count).by(1)
      end

      it "redirects to profile#new" do
        post :create, profile: build_attributes(:profile)
        expect(response).to redirect_to Profile.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new profile in the database" do
        expect{
          post :create, profile: FactoryGirl.attributes_for(:profile, section_name: nil)
        }.to_not change(Profile,:count)
      end
      it "re-renders the :new template" do
        post :create, profile: FactoryGirl.attributes_for(:profile, section_name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :manager_user

    before :each do
      @profile = FactoryGirl.create(:profile, section_name: 'profile 1')
    end

    context "valid attributes" do
      it "locates the requested @profile" do
        put :update, id: @profile, profile: FactoryGirl.attributes_for(:profile)
        expect(assigns(:profile)).to eq(@profile)
      end

      it "changes @profile's attributes" do
        put :update, id: @profile,
            profile: FactoryGirl.attributes_for(:profile, section_name: "profile 2")
        @profile.reload
        expect(@profile.section_name).to eq("profile 2")
      end

      it "redirects to the updated profile" do
        put :update, id: @profile, profile: FactoryGirl.attributes_for(:profile)
        expect(response).to redirect_to @profile
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile" do
        put :update, id: @profile, profile: FactoryGirl.attributes_for(:profile, section_name: nil)
        expect(assigns(:profile)).to eq(@profile)
      end

      it "does not change @profile's attributes" do
        put :update, id: @profile,
            profile: FactoryGirl.attributes_for(:profile, section_name: nil)
        @profile.reload
        expect(@profile.section_name).to eq("profile 1")
      end

      it "re-renders the edit method" do
        put :update, id: @profile, profile: FactoryGirl.attributes_for(:profile, section_name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :manager_user

    before :each do
      @profile = FactoryGirl.create(:profile)
    end

    it "deletes an profile" do
      expect{
        delete :destroy, :id => @profile
      }.to change(Profile, :count).by(-1)
    end

    it "redirects to profiles#index" do
      delete :destroy, :id => @profile
      expect(response).to redirect_to profiles_url
    end
  end

end
