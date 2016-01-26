require 'rails_helper'

RSpec.describe UsersController, type: :controller do

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
    login_user :manager_user

    it "requires sufficient privilages to create" do
      expect{
        post :create, user: FactoryGirl.attributes_for(:user)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:user)
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
    login_user :admin_user

    before :each do
      @user = FactoryGirl.create(:user)
      @response = get :index
    end

    it "populates an array of users" do
      expect(assigns(:users)).to include(@user)
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :admin_user

    before :each do
      @user = FactoryGirl.create(:user)
      @response = get :show, id: @user
    end

    it "assigns the requested user to @user" do
      expect(assigns(:user)).to eq(@user)
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
    it "assigns a new user to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :admin_user

    context "with valid attributes" do
      it "creates an user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to user#new" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to users_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user, name: nil)
        }.to_not change(User,:count)
      end
      it "re-renders the :new template" do
        post :create, user: FactoryGirl.attributes_for(:user, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :admin_user

    before :each do
      @user = FactoryGirl.create(:user, name: 'user 1', email: 'user@user.com', password:'password 1')
    end

    context "valid attributes" do
      it "locates the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        put :update, id: @user,
            user: FactoryGirl.attributes_for(:user, name:'user 2', email: 'user2@user.com', password:'password 2')
        @user.reload
        expect(@user.name).to eq('user 2')
        # expect(@user.email).to eq('user2@user.com')
        # expect(@user.password).to eq('password 2')
      end

      it "redirects to the updated user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to @user
      end
    end

    context "invalid attributes" do
      it "locates the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: nil)
        expect(assigns(:user)).to eq(@user)
      end

      it "does not change @user's attributes" do
        put :update, id: @user,
            user: FactoryGirl.attributes_for(:user, name: nil)
        @user.reload
        expect(@user.name).to eq('user 1')
        expect(@user.email).to eq('user@user.com')
        expect(@user.password).to eq('password 1')
      end

      it "re-renders the edit method" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :admin_user

    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "deletes an user" do
      expect{
        delete :destroy, :id => @user
      }.to change(User, :count).by(-1)
    end

    it "redirects to users#index" do
      delete :destroy, :id => @user
      expect(response).to redirect_to users_url
    end
  end

end
