require 'rails_helper'

RSpec.describe ProfilePersonalDetailsController, type: :controller do

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
        post :create, profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:profile_personal_detail)
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
      @profile_personal_detail = FactoryGirl.create(:profile_personal_detail)
      @response = get :index
    end

    it "populates an array of profile_personal_details" do
      expect(assigns(:profile_personal_details)).to eq([@profile_personal_detail])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @profile_personal_detail = FactoryGirl.create(:profile_personal_detail)
      @response = get :show, id: @profile_personal_detail
    end

    it "assigns the requested profile_personal_detail to @profile_personal_detail" do
      expect(assigns(:profile_personal_detail)).to eq(@profile_personal_detail)
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
    it "assigns a new profile_personal_detail to @profile_personal_detail" do
      expect(assigns(:profile_personal_detail)).to be_a_new(ProfilePersonalDetail)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :manager_user

    context "with valid attributes" do
      it "creates a profile_personal_detail" do
        expect{
          post :create, profile_personal_detail: build_attributes(:profile_personal_detail)
        }.to change(ProfilePersonalDetail, :count).by(1)
      end

      it "redirects to profile_personal_detail#new" do
        post :create, profile_personal_detail: build_attributes(:profile_personal_detail)
        expect(response).to redirect_to ProfilePersonalDetail.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new profile_personal_detail in the database" do
        expect{
          post :create, profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: nil)
        }.to_not change(ProfilePersonalDetail,:count)
      end
      it "re-renders the :new template" do
        post :create, profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :manager_user

    before :each do
      @profile_personal_detail = FactoryGirl.create(:profile_personal_detail, first_name: 'first_name 1', other_names: 'other names 1',
                                                   religion: 'religion 1', sex: 'Male', marital_status: 'Married',
                                                   birthday: Date.yesterday, nationality: 'nationality 1', languages: 'language 1')
    end

    context "valid attributes" do
      it "locates the requested @profile_personal_detail" do
        put :update, id: @profile_personal_detail,
            profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: 'first_name 1', other_names: 'other names 1',
                                                               religion: 'religion 1', sex: 'Male', marital_status: 'Married',
                                                               birthday: Date.yesterday, nationality: 'nationality 1', languages: 'language 1')
        expect(assigns(:profile_personal_detail)).to eq(@profile_personal_detail)
      end

      it "changes @profile_personal_detail's attributes" do
        put :update, id: @profile_personal_detail,
            profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: 'first_name 2', other_names: 'other names 2',
                                                               religion: 'religion 2', sex: 'Female', marital_status: 'Complicated',
                                                               birthday: Date.today, nationality: 'nationality 2', languages: 'language 2')
        @profile_personal_detail.reload
        expect(@profile_personal_detail.first_name).to eq("first_name 2")
        expect(@profile_personal_detail.other_names).to eq("other names 2")
        expect(@profile_personal_detail.religion).to eq("religion 2")
        expect(@profile_personal_detail.sex).to eq('Female')
        expect(@profile_personal_detail.marital_status).to eq("Complicated")
        expect(@profile_personal_detail.birthday).to eq(Date.today)
        expect(@profile_personal_detail.nationality).to eq('nationality 2')
        expect(@profile_personal_detail.languages).to eq("language 2")
      end

      it "redirects to the updated profile_personal_detail" do
        put :update, id: @profile_personal_detail, profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail)
        expect(response).to redirect_to @profile_personal_detail
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile_personal_detail" do
        put :update, id: @profile_personal_detail, profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: nil)
        expect(assigns(:profile_personal_detail)).to eq(@profile_personal_detail)
      end

      it "does not change @profile_personal_detail's attributes" do
        put :update, id: @profile_personal_detail,
            profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: nil)
        @profile_personal_detail.reload
        expect(@profile_personal_detail.first_name).to eq("first_name 1")
        expect(@profile_personal_detail.other_names).to eq("other names 1")
        expect(@profile_personal_detail.religion).to eq("religion 1")
        expect(@profile_personal_detail.sex).to eq('Male')
        expect(@profile_personal_detail.marital_status).to eq("Married")
        expect(@profile_personal_detail.birthday).to eq(Date.yesterday)
        expect(@profile_personal_detail.nationality).to eq('nationality 1')
        expect(@profile_personal_detail.languages).to eq("language 1")
      end

      it "re-renders the edit method" do
        put :update, id: @profile_personal_detail, profile_personal_detail: FactoryGirl.attributes_for(:profile_personal_detail, first_name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :manager_user

    before :each do
      @profile_personal_detail = FactoryGirl.create(:profile_personal_detail)
    end

    it "deletes an profile_personal_detail" do
      expect{
        delete :destroy, :id => @profile_personal_detail
      }.to change(ProfilePersonalDetail, :count).by(-1)
    end

    it "redirects to profile_personal_details#index" do
      delete :destroy, :id => @profile_personal_detail
      expect(response).to redirect_to profile_personal_details_url
    end
  end

end
