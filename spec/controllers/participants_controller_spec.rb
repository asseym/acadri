require 'rails_helper'

RSpec.describe ParticipantsController, type: :controller do

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
        post :create, participant: FactoryGirl.attributes_for(:participant)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:participant)
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
      @participant = FactoryGirl.create(:participant)
      @response = get :index
    end

    it "populates an array of participants" do
      expect(assigns(:participants)).to eq([@participant])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @participant = FactoryGirl.create(:participant)
      @response = get :show, id: @participant
    end

    it "assigns the requested participant to @participant" do
      expect(assigns(:participant)).to eq(@participant)
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
    it "assigns a new participant to @participant" do
      expect(assigns(:participant)).to be_a_new(Participant)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :program_coordinator_user

    context "with valid attributes" do
      it "creates an participant" do
        expect{
          post :create, participant: build_attributes(:participant)
        }.to change(Participant, :count).by(1)
      end

      it "redirects to participant#new" do
        post :create, participant: build_attributes(:participant)
        expect(response).to redirect_to Participant.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new participant in the database" do
        expect{
          post :create, participant: FactoryGirl.attributes_for(:participant, name: nil)
        }.to_not change(Participant,:count)
      end
      it "re-renders the :new template" do
        post :create, participant: FactoryGirl.attributes_for(:participant, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :program_coordinator_user

    before :each do
      @participant = FactoryGirl.create(:participant, name: 'participant 1', other_names: 'other names 1',
                                        passport_no: '123', job_title: 'job title 1',
                                        organisation: FactoryGirl.create(:organisation, name: 'organisation 1'))
    end

    context "valid attributes" do
      it "locates the requested @participant" do
        put :update, id: @participant, participant: FactoryGirl.attributes_for(:participant)
        expect(assigns(:participant)).to eq(@participant)
      end

      it "changes @participant's attributes" do
        put :update, id: @participant,
            participant: FactoryGirl.attributes_for(:participant, name: 'participant 2', other_names: 'other names 2',
                                                    sex: 'Female', passport_no: '12345', job_title: 'job title 2')
        @participant.reload
        expect(@participant.name).to eq("participant 2")
        expect(@participant.other_names).to eq("other names 2")
        expect(@participant.sex).to eq("Female")
        expect(@participant.passport_no).to eq("12345")
        expect(@participant.job_title).to eq("job title 2")
      end

      it "redirects to the updated participant" do
        put :update, id: @participant, participant: FactoryGirl.attributes_for(:participant)
        expect(response).to redirect_to @participant
      end
    end

    context "invalid attributes" do
      it "locates the requested @participant" do
        put :update, id: @participant, participant: FactoryGirl.attributes_for(:participant, name: nil)
        expect(assigns(:participant)).to eq(@participant)
      end

      it "does not change @participant's attributes" do
        put :update, id: @participant,
            participant: FactoryGirl.attributes_for(:participant, name: nil)
        @participant.reload
        expect(@participant.name).to eq("participant 1")
        expect(@participant.other_names).to eq("other names 1")
        expect(@participant.sex).to eq("Male")
        expect(@participant.passport_no).to eq("123")
        expect(@participant.job_title).to eq("job title 1")
        expect(@participant.organisation.name).to eq("organisation 1")
      end

      it "re-renders the edit method" do
        put :update, id: @participant, participant: FactoryGirl.attributes_for(:participant, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :program_coordinator_user

    before :each do
      @participant = FactoryGirl.create(:participant)
    end

    it "deletes an participant" do
      expect{
        delete :destroy, :id => @participant
      }.to change(Participant, :count).by(-1)
    end

    it "redirects to participants#index" do
      delete :destroy, :id => @participant
      expect(response).to redirect_to participants_url
    end
  end

end
