require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

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
        post :create, category: FactoryGirl.attributes_for(:category)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:category)
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
      @category = FactoryGirl.create(:category)
      @response = get :index
    end

    it "populates an array of categories" do
      expect(assigns(:categories)).to eq([@category])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @category = FactoryGirl.create(:category)
      @response = get :show, id: @category
    end

    it "assigns the requested category to @category" do
      expect(assigns(:category)).to eq(@category)
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
    it "assigns a new Category to @category" do
      expect(assigns(:category)).to be_a_new(Category)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :admin_user

    context "with valid attributes" do
      it "creates an category" do
        expect{
          post :create, category: FactoryGirl.attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it "redirects to category#new" do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to Category.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new category in the database" do
        expect{
          post :create, category: FactoryGirl.attributes_for(:category, name: nil)
        }.to_not change(Category,:count)
      end
      it "re-renders the :new template" do
        post :create, category: FactoryGirl.attributes_for(:category, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :admin_user

    before :each do
      @category = FactoryGirl.create(:category, name: 'category 1')
    end

    context "valid attributes" do
      it "locates the requested @category" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category)
        expect(assigns(:category)).to eq(@category)
      end

      it "changes @category's attributes" do
        put :update, id: @category,
            category: FactoryGirl.attributes_for(:category, name: "category 2")
        @category.reload
        expect(@category.name).to eq("category 2")
      end

      it "redirects to the updated category" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to @category
      end
    end

    context "invalid attributes" do
      it "locates the requested @category" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: nil)
        expect(assigns(:category)).to eq(@category)
      end

      it "does not change @category's attributes" do
        put :update, id: @category,
            category: FactoryGirl.attributes_for(:category, name: nil)
        @category.reload
        expect(@category.name).to eq("category 1")
      end

      it "re-renders the edit method" do
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :admin_user

    before :each do
      @category = FactoryGirl.create(:category)
    end

    it "deletes an category" do
      expect{
        delete :destroy, :id => @category
      }.to change(Category, :count).by(-1)
    end

    it "redirects to categorys#index" do
      delete :destroy, :id => @category
      expect(response).to redirect_to categories_url
    end
  end

end
