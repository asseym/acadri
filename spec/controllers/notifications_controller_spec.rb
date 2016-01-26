require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

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
        post :create, notification: FactoryGirl.attributes_for(:notification)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:notification)
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
      @notification = FactoryGirl.create(:notification)
      @response = get :index
    end

    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @notification = FactoryGirl.create(:notification)
      @response = get :show, id: @notification
    end

    it "assigns the requested notification to @notification" do
      expect(assigns(:notification)).to eq(@notification)
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
    it "assigns a new notification to @notification" do
      expect(assigns(:notification)).to be_a_new(Notification)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :admin_user

    context "with valid attributes" do
      it "creates an notification" do
        expect{
          post :create, notification: FactoryGirl.attributes_for(:notification)
        }.to change(Notification, :count).by(1)
      end

      it "redirects to notification#new" do
        post :create, notification: FactoryGirl.attributes_for(:notification)
        expect(response).to redirect_to Notification.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new notification in the database" do
        expect{
          post :create, notification: FactoryGirl.attributes_for(:notification, notification: nil)
        }.to_not change(Notification,:count)
      end
      it "re-renders the :new template" do
        post :create, notification: FactoryGirl.attributes_for(:notification, notification: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :admin_user

    before :each do
      @notification = FactoryGirl.create(:notification, notification: 'notification 1')
    end

    context "valid attributes" do
      it "locates the requested @notification" do
        put :update, id: @notification, notification: FactoryGirl.attributes_for(:notification)
        expect(assigns(:notification)).to eq(@notification)
      end

      it "changes @notification's attributes" do
        put :update, id: @notification,
            notification: FactoryGirl.attributes_for(:notification, notification: "notification 2")
        @notification.reload
        expect(@notification.notification).to eq("notification 2")
      end

      it "redirects to the updated notification" do
        put :update, id: @notification, notification: FactoryGirl.attributes_for(:notification)
        expect(response).to redirect_to @notification
      end
    end

    context "invalid attributes" do
      it "locates the requested @notification" do
        put :update, id: @notification, notification: FactoryGirl.attributes_for(:notification, notification: nil)
        expect(assigns(:notification)).to eq(@notification)
      end

      it "does not change @notification's attributes" do
        put :update, id: @notification,
            notification: FactoryGirl.attributes_for(:notification, notification: nil)
        @notification.reload
        expect(@notification.notification).to eq("notification 1")
      end

      it "re-renders the edit method" do
        put :update, id: @notification, notification: FactoryGirl.attributes_for(:notification, notification: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :admin_user

    before :each do
      @notification = FactoryGirl.create(:notification)
    end

    it "deletes an notification" do
      expect{
        delete :destroy, :id => @notification
      }.to change(Notification, :count).by(-1)
    end

    it "redirects to notifications#index" do
      delete :destroy, :id => @notification
      expect(response).to redirect_to notifications_url
    end
  end

end
