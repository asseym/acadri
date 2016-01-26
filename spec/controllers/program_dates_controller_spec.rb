require 'rails_helper'

RSpec.describe ProgramDatesController, type: :controller do

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
        post :create, program_date: FactoryGirl.attributes_for(:program_date)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:program_date)
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
      @program_date = FactoryGirl.create(:program_date)
      @response = get :index
    end

    it "populates an array of program_dates" do
      expect(assigns(:program_dates)).to eq([@program_date])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @program_date = FactoryGirl.create(:program_date)
      @response = get :show, id: @program_date
    end

    it "assigns the requested program_date to @program_date" do
      expect(assigns(:program_date)).to eq(@program_date)
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
    it "assigns a new program_date to @program_date" do
      expect(assigns(:program_date)).to be_a_new(ProgramDate)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :program_coordinator_user

    context "with valid attributes" do
      it "creates an program_date" do
        expect{
          post :create, program_date: FactoryGirl.attributes_for(:program_date)
        }.to change(ProgramDate, :count).by(1)
      end

      it "redirects to program_date#new" do
        post :create, program_date: FactoryGirl.attributes_for(:program_date)
        expect(response).to redirect_to ProgramDate.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new program_date in the database" do
        expect{
          post :create, program_date: FactoryGirl.attributes_for(:program_date, start_date: nil)
        }.to_not change(ProgramDate,:count)
      end
      it "re-renders the :new template" do
        post :create, program_date: FactoryGirl.attributes_for(:program_date, start_date: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :program_coordinator_user

    before :each do
      @program_date = FactoryGirl.create(:program_date, start_date: Date.today, end_date: Date.tomorrow)
    end

    context "valid attributes" do
      it "locates the requested @program_date" do
        put :update, id: @program_date, program_date: FactoryGirl.attributes_for(:program_date)
        expect(assigns(:program_date)).to eq(@program_date)
      end

      it "changes @program_date's attributes" do
        put :update, id: @program_date,
            program_date: FactoryGirl.attributes_for(:program_date, start_date: Date.yesterday, end_date: Date.today)
        @program_date.reload
        expect(@program_date.start_date).to eq(Date.yesterday)
        expect(@program_date.end_date).to eq(Date.today)
      end

      it "redirects to the updated program_date" do
        put :update, id: @program_date, program_date: FactoryGirl.attributes_for(:program_date)
        expect(response).to redirect_to @program_date
      end
    end

    context "invalid attributes" do
      it "locates the requested @program_date" do
        put :update, id: @program_date, program_date: FactoryGirl.attributes_for(:program_date, start_date: nil)
        expect(assigns(:program_date)).to eq(@program_date)
      end

      it "does not change @program_date's attributes" do
        put :update, id: @program_date,
            program_date: FactoryGirl.attributes_for(:program_date, start_date: nil)
        @program_date.reload
        expect(@program_date.start_date).to eq(Date.today)
        expect(@program_date.end_date).to eq(Date.tomorrow)
      end

      it "re-renders the edit method" do
        put :update, id: @program_date, program_date: FactoryGirl.attributes_for(:program_date, start_date: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :program_coordinator_user

    before :each do
      @program_date = FactoryGirl.create(:program_date)
    end

    it "deletes an program_date" do
      expect{
        delete :destroy, :id => @program_date
      }.to change(ProgramDate, :count).by(-1)
    end

    it "redirects to program_dates#index" do
      delete :destroy, :id => @program_date
      expect(response).to redirect_to program_dates_url
    end
  end

end
