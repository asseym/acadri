require 'rails_helper'

RSpec.describe ProgramsController, type: :controller do

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
        post :create, program: FactoryGirl.attributes_for(:program)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:program)
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
      @program = FactoryGirl.create(:program)
      @response = get :index
    end

    it "populates an array of programs" do
      expect(assigns(:programs)).to eq([@program])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @program = FactoryGirl.create(:program)
      @response = get :show, id: @program
    end

    it "assigns the requested program to @program" do
      expect(assigns(:program)).to eq(@program)
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
    it "assigns a new program to @program" do
      expect(assigns(:program)).to be_a_new(Program)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :program_coordinator_user

    context "with valid attributes" do
      it "creates an program" do
        expect{
          post :create, program: build_attributes(:program)
        }.to change(Program, :count).by(1)
      end

      it "redirects to program#new" do
        post :create, program: build_attributes(:program)
        expect(response).to redirect_to programs_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new program in the database" do
        expect{
          post :create, program: FactoryGirl.attributes_for(:program, name: nil)
        }.to_not change(Program,:count)
      end
      it "re-renders the :new template" do
        post :create, program: FactoryGirl.attributes_for(:program, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :program_coordinator_user

    before :each do
      @program = FactoryGirl.create(:program, name: 'program 1', description: 'description 1')
    end

    context "valid attributes" do
      it "locates the requested @program" do
        put :update, id: @program, program: FactoryGirl.attributes_for(:program)
        expect(assigns(:program)).to eq(@program)
      end

      it "changes @program's attributes" do
        put :update, id: @program,
            program: FactoryGirl.attributes_for(:program, name:'program 2', description:'description 2', is_service:false)
        @program.reload
        expect(@program.name).to eq('program 2')
        expect(@program.description).to eq('description 2')
        expect(@program.is_service).to eq(false)
      end

      it "redirects to the updated program" do
        put :update, id: @program, program: FactoryGirl.attributes_for(:program)
        expect(response).to redirect_to @program
      end
    end

    context "invalid attributes" do
      it "locates the requested @program" do
        put :update, id: @program, program: FactoryGirl.attributes_for(:program, name: nil)
        expect(assigns(:program)).to eq(@program)
      end

      it "does not change @program's attributes" do
        put :update, id: @program,
            program: FactoryGirl.attributes_for(:program, name: nil)
        @program.reload
        expect(@program.name).to eq('program 1')
        expect(@program.description).to eq('description 1')
        expect(@program.is_service).to eq(true)
      end

      it "re-renders the edit method" do
        put :update, id: @program, program: FactoryGirl.attributes_for(:program, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :program_coordinator_user

    before :each do
      @program = FactoryGirl.create(:program)
    end

    it "deletes an program" do
      expect{
        delete :destroy, :id => @program
      }.to change(Program, :count).by(-1)
    end

    it "redirects to programs#index" do
      delete :destroy, :id => @program
      expect(response).to redirect_to programs_url
    end
  end

end
