require 'rails_helper'

RSpec.describe ProfileGeneralDetailsController, type: :controller do

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
        post :create, profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:profile_general_detail)
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
      @profile_general_detail = FactoryGirl.create(:profile_general_detail)
      @response = get :index
    end

    it "populates an array of profile_general_details" do
      expect(assigns(:profile_general_details)).to eq([@profile_general_detail])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @profile_general_detail = FactoryGirl.create(:profile_general_detail)
      @response = get :show, id: @profile_general_detail
    end

    it "assigns the requested profile_general_detail to @profile_general_detail" do
      expect(assigns(:profile_general_detail)).to eq(@profile_general_detail)
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
    it "assigns a new profile_general_detail to @profile_general_detail" do
      expect(assigns(:profile_general_detail)).to be_a_new(ProfileGeneralDetail)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :manager_user

    context "with valid attributes" do
      it "creates a profile_general_detail" do
        expect{
          post :create, profile_general_detail: build_attributes(:profile_general_detail)
        }.to change(ProfileGeneralDetail, :count).by(1)
      end

      it "redirects to profile_general_detail#new" do
        post :create, profile_general_detail: build_attributes(:profile_general_detail)
        expect(response).to redirect_to ProfileGeneralDetail.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new profile_general_detail in the database" do
        expect{
          post :create, profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, address: nil)
        }.to_not change(ProfileGeneralDetail,:count)
      end
      it "re-renders the :new template" do
        post :create, profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, address: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :manager_user

    before :each do
      @profile_general_detail = FactoryGirl.create(:profile_general_detail, title: 'title 1', education: 'educ 1',
                                                   staff_id: 'staff id 1', date_hired: Date.today, passport_number: '1234',
                                                   drivers_licence: '1234', salary: 1234, NSSF_number: '1234')
    end

    context "valid attributes" do
      it "locates the requested @profile_general_detail" do
        put :update, id: @profile_general_detail,
            profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, title: 'title 1', education: 'educ 1',
                                                               staff_id: 'staff id 1', date_hired: Date.today, passport_number: '1234',
                                                               drivers_licence: '1234', salary: 1234, NSSF_number: '1234')
        expect(assigns(:profile_general_detail)).to eq(@profile_general_detail)
      end

      it "changes @profile_general_detail's attributes" do
        put :update, id: @profile_general_detail,
            profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, title: 'title 2', education: 'educ 2',
                                                               staff_id: 'staff id 2', date_hired: Date.yesterday, passport_number: '123',
                                                               drivers_licence: '123', salary: 123, NSSF_number: '123')
        @profile_general_detail.reload
        expect(@profile_general_detail.title).to eq("title 2")
        expect(@profile_general_detail.education).to eq("educ 2")
        expect(@profile_general_detail.staff_id).to eq("staff id 2")
        expect(@profile_general_detail.date_hired).to eq(Date.yesterday)
        expect(@profile_general_detail.passport_number).to eq("123")
        expect(@profile_general_detail.drivers_licence).to eq("123")
        expect(@profile_general_detail.salary).to eq(123)
        expect(@profile_general_detail.NSSF_number).to eq("123")
      end

      it "redirects to the updated profile_general_detail" do
        put :update, id: @profile_general_detail, profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail)
        expect(response).to redirect_to @profile_general_detail
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile_general_detail" do
        put :update, id: @profile_general_detail, profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, title: nil)
        expect(assigns(:profile_general_detail)).to eq(@profile_general_detail)
      end

      it "does not change @profile_general_detail's attributes" do
        put :update, id: @profile_general_detail,
            profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, title: nil)
        @profile_general_detail.reload
        expect(@profile_general_detail.title).to eq("title 1")
        expect(@profile_general_detail.education).to eq("educ 1")
        expect(@profile_general_detail.staff_id).to eq("staff id 1")
        expect(@profile_general_detail.date_hired).to eq(Date.today)
        expect(@profile_general_detail.passport_number).to eq("1234")
        expect(@profile_general_detail.drivers_licence).to eq("1234")
        expect(@profile_general_detail.salary).to eq(1234)
        expect(@profile_general_detail.NSSF_number).to eq("1234")
      end

      it "re-renders the edit method" do
        put :update, id: @profile_general_detail, profile_general_detail: FactoryGirl.attributes_for(:profile_general_detail, title: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :manager_user

    before :each do
      @profile_general_detail = FactoryGirl.create(:profile_general_detail)
    end

    it "deletes an profile_general_detail" do
      expect{
        delete :destroy, :id => @profile_general_detail
      }.to change(ProfileGeneralDetail, :count).by(-1)
    end

    it "redirects to profile_general_details#index" do
      delete :destroy, :id => @profile_general_detail
      expect(response).to redirect_to profile_general_details_url
    end
  end

end
