require 'rails_helper'

RSpec.describe TrainingsController, type: :controller do

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
        post :create, training: FactoryGirl.attributes_for(:training)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:training)
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
      @training = FactoryGirl.create(:training)
      @response = get :index
    end

    it "populates an array of trainings" do
      expect(assigns(:trainings)).to eq([@training])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @training = FactoryGirl.create(:training)
      @response = get :show, id: @training
    end

    it "assigns the requested training to @training" do
      expect(assigns(:training)).to eq(@training)
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
    it "assigns a new training to @training" do
      expect(assigns(:training)).to be_a_new(Training)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :program_coordinator_user

    context "with valid attributes" do
      it "creates an training" do
        expect{
          post :create, training: build_attributes(:training)
        }.to change(Training, :count).by(1)
      end

      it "redirects to training#new" do
        post :create, training: build_attributes(:training)
        expect(response).to redirect_to Training.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new training in the database" do
        expect{
          post :create, training: FactoryGirl.attributes_for(:training, start_date: nil)
        }.to_not change(Training,:count)
      end
      it "re-renders the :new template" do
        post :create, training: FactoryGirl.attributes_for(:training, start_date: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :program_coordinator_user

    before :each do
      @training = FactoryGirl.create(:training, title: 'training 1', start_date: Date.today, end_date: Date.tomorrow, fees: 5,
                                     fees_paid: 4, fees_balance: 1)
    end

    context "valid attributes" do
      it "locates the requested @training" do
        put :update, id: @training, training: FactoryGirl.attributes_for(:training)
        expect(assigns(:training)).to eq(@training)
      end

      it "changes @training's attributes" do
        put :update, id: @training,
            training: FactoryGirl.attributes_for(:training, title: 'training 2', start_date: Date.yesterday, end_date: Date.today, fees: 4,
                                                 fees_paid: 2, fees_balance: 2)
        @training.reload
        expect(@training.title).to eq('training 2')
        expect(@training.start_date).to eq(Date.yesterday)
        expect(@training.end_date).to eq(Date.today)
        expect(@training.fees).to eq(4)
        expect(@training.fees_paid).to eq(2)
        expect(@training.fees_balance).to eq(2)
      end

      it "redirects to the updated training" do
        put :update, id: @training, training: FactoryGirl.attributes_for(:training)
        expect(response).to redirect_to @training
      end
    end

    context "invalid attributes" do
      it "locates the requested @training" do
        put :update, id: @training, training: FactoryGirl.attributes_for(:training, start_date: nil)
        expect(assigns(:training)).to eq(@training)
      end

      it "does not change @training's attributes" do
        put :update, id: @training,
            training: FactoryGirl.attributes_for(:training, start_date: nil)
        @training.reload
        expect(@training.title).to eq('training 1')
        expect(@training.start_date).to eq(Date.today)
        expect(@training.end_date).to eq(Date.tomorrow)
        expect(@training.fees).to eq(5)
        expect(@training.fees_paid).to eq(4)
        expect(@training.fees_balance).to eq(1)
      end

      it "re-renders the edit method" do
        put :update, id: @training, training: FactoryGirl.attributes_for(:training, start_date: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :program_coordinator_user

    before :each do
      @training = FactoryGirl.create(:training)
    end

    it "deletes an training" do
      expect{
        delete :destroy, :id => @training
      }.to change(Training, :count).by(-1)
    end

    it "redirects to trainings#index" do
      delete :destroy, :id => @training
      expect(response).to redirect_to trainings_url
    end
  end

end
