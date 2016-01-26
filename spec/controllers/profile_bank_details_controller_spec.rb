require 'rails_helper'

RSpec.describe ProfileBankDetailsController, type: :controller do

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
        post :create, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:profile_bank_detail)
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
      @profile_bank_detail = FactoryGirl.create(:profile_bank_detail)
      @response = get :index
    end

    it "populates an array of profile_bank_details" do
      expect(assigns(:profile_bank_details)).to eq([@profile_bank_detail])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @profile_bank_detail = FactoryGirl.create(:profile_bank_detail)
      @response = get :show, id: @profile_bank_detail
    end

    it "assigns the requested profile_bank_detail to @profile_bank_detail" do
      expect(assigns(:profile_bank_detail)).to eq(@profile_bank_detail)
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
    it "assigns a new profile_bank_detail to @profile_bank_detail" do
      expect(assigns(:profile_bank_detail)).to be_a_new(ProfileBankDetail)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :manager_user

    context "with valid attributes" do
      it "creates an profile_bank_detail" do
        expect{
          post :create, profile_bank_detail: build_attributes(:profile_bank_detail)
        }.to change(ProfileBankDetail, :count).by(1)
      end

      it "redirects to profile_bank_detail#new" do
        post :create, profile_bank_detail: build_attributes(:profile_bank_detail)
        expect(response).to redirect_to ProfileBankDetail.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new profile_bank_detail in the database" do
        expect{
          post :create, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail, bank_details: nil)
        }.to_not change(ProfileBankDetail,:count)
      end
      it "re-renders the :new template" do
        post :create, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail, bank_details: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :manager_user

    before :each do
      @profile_bank_detail = FactoryGirl.create(:profile_bank_detail, bank_details: 'profile_bank_detail 1')
    end

    context "valid attributes" do
      it "locates the requested @profile_bank_detail" do
        put :update, id: @profile_bank_detail, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail)
        expect(assigns(:profile_bank_detail)).to eq(@profile_bank_detail)
      end

      it "changes @profile_bank_detail's attributes" do
        put :update, id: @profile_bank_detail,
            profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail, bank_details: 'profile_bank_detail 2')
        @profile_bank_detail.reload
        expect(@profile_bank_detail.bank_details).to eq("profile_bank_detail 2")
      end

      it "redirects to the updated profile_bank_detail" do
        put :update, id: @profile_bank_detail, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail)
        expect(response).to redirect_to @profile_bank_detail
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile_bank_detail" do
        put :update, id: @profile_bank_detail, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail, bank_details: nil)
        expect(assigns(:profile_bank_detail)).to eq(@profile_bank_detail)
      end

      it "does not change @profile_bank_detail's attributes" do
        put :update, id: @profile_bank_detail,
            profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail, bank_details: nil)
        @profile_bank_detail.reload
        expect(@profile_bank_detail.bank_details).to eq("profile_bank_detail 1")
      end

      it "re-renders the edit method" do
        put :update, id: @profile_bank_detail, profile_bank_detail: FactoryGirl.attributes_for(:profile_bank_detail, bank_details: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :manager_user

    before :each do
      @profile_bank_detail = FactoryGirl.create(:profile_bank_detail)
    end

    it "deletes an profile_bank_detail" do
      expect{
        delete :destroy, :id => @profile_bank_detail
      }.to change(ProfileBankDetail, :count).by(-1)
    end

    it "redirects to profile_bank_details#index" do
      delete :destroy, :id => @profile_bank_detail
      expect(response).to redirect_to profile_bank_details_url
    end
  end

end
