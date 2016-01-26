require 'rails_helper'

RSpec.describe ProfileContactDetailsController, type: :controller do

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
        post :create, profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:profile_contact_detail)
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
      @profile_contact_detail = FactoryGirl.create(:profile_contact_detail)
      @response = get :index
    end

    it "populates an array of profile_contact_details" do
      expect(assigns(:profile_contact_details)).to eq([@profile_contact_detail])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @profile_contact_detail = FactoryGirl.create(:profile_contact_detail)
      @response = get :show, id: @profile_contact_detail
    end

    it "assigns the requested profile_contact_detail to @profile_contact_detail" do
      expect(assigns(:profile_contact_detail)).to eq(@profile_contact_detail)
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
    it "assigns a new profile_contact_detail to @profile_contact_detail" do
      expect(assigns(:profile_contact_detail)).to be_a_new(ProfileContactDetail)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :manager_user

    context "with valid attributes" do
      it "creates an profile_contact_detail" do
        expect{
          post :create, profile_contact_detail: build_attributes(:profile_contact_detail)
        }.to change(ProfileContactDetail, :count).by(1)
      end

      it "redirects to profile_contact_detail#new" do
        post :create, profile_contact_detail: build_attributes(:profile_contact_detail)
        expect(response).to redirect_to ProfileContactDetail.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new profile_contact_detail in the database" do
        expect{
          post :create, profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: nil)
        }.to_not change(ProfileContactDetail,:count)
      end
      it "re-renders the :new template" do
        post :create, profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :manager_user

    before :each do
      @profile_contact_detail = FactoryGirl.create(:profile_contact_detail, address: 'address 1', email_address: 'email@email.com',
                                                   business_phone: 'business phone 1', 'mobile_phone': 'mobile phone 1',
                                                   home_phone: 'home_phone 1', fax: 'fax 1')
    end

    context "valid attributes" do
      it "locates the requested @profile_contact_detail" do
        put :update, id: @profile_contact_detail,
            profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: 'address 1', email_address: 'email@email.com',
                                                   business_phone: 'business phone 1', 'mobile_phone': 'mobile phone 1',
                                                   home_phone: 'home_phone 1', fax: 'fax 1')
        expect(assigns(:profile_contact_detail)).to eq(@profile_contact_detail)
      end

      it "changes @profile_contact_detail's attributes" do
        put :update, id: @profile_contact_detail,
            profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: 'address 2', email_address: 'email2@email.com',
                                                               business_phone: 'business phone 2', 'mobile_phone': 'mobile phone 2',
                                                               home_phone: 'home_phone 2', fax: 'fax 2')
        @profile_contact_detail.reload
        expect(@profile_contact_detail.address).to eq("address 2")
        expect(@profile_contact_detail.email_address).to eq("email2@email.com")
        expect(@profile_contact_detail.business_phone).to eq("business phone 2")
        expect(@profile_contact_detail.mobile_phone).to eq("mobile phone 2")
        expect(@profile_contact_detail.home_phone).to eq("home_phone 2")
        expect(@profile_contact_detail.fax).to eq("fax 2")
      end

      it "redirects to the updated profile_contact_detail" do
        put :update, id: @profile_contact_detail, profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail)
        expect(response).to redirect_to @profile_contact_detail
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile_contact_detail" do
        put :update, id: @profile_contact_detail, profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: nil)
        expect(assigns(:profile_contact_detail)).to eq(@profile_contact_detail)
      end

      it "does not change @profile_contact_detail's attributes" do
        put :update, id: @profile_contact_detail,
            profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: nil)
        @profile_contact_detail.reload
        expect(@profile_contact_detail.address).to eq("address 1")
        expect(@profile_contact_detail.email_address).to eq("email@email.com")
        expect(@profile_contact_detail.business_phone).to eq("business phone 1")
        expect(@profile_contact_detail.mobile_phone).to eq("mobile phone 1")
        expect(@profile_contact_detail.home_phone).to eq("home_phone 1")
        expect(@profile_contact_detail.fax).to eq("fax 1")
      end

      it "re-renders the edit method" do
        put :update, id: @profile_contact_detail, profile_contact_detail: FactoryGirl.attributes_for(:profile_contact_detail, address: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :manager_user

    before :each do
      @profile_contact_detail = FactoryGirl.create(:profile_contact_detail)
    end

    it "deletes an profile_contact_detail" do
      expect{
        delete :destroy, :id => @profile_contact_detail
      }.to change(ProfileContactDetail, :count).by(-1)
    end

    it "redirects to profile_contact_details#index" do
      delete :destroy, :id => @profile_contact_detail
      expect(response).to redirect_to profile_contact_details_url
    end
  end

end
