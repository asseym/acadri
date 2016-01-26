require 'rails_helper'

RSpec.describe OpportunitiesController, type: :controller do

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
        post :create, opportunity: FactoryGirl.attributes_for(:opportunity)
      }.to raise_error(CanCan::AccessDenied)
    end

    it "requires sufficient privilages to destroy" do
      expect{
        delete :destroy, :id => FactoryGirl.create(:opportunity)
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
      @opportunity = FactoryGirl.create(:opportunity)
      @response = get :index
    end

    it "populates an array of opportunities" do
      expect(assigns(:opportunities)).to eq([@opportunity])
    end
    it "renders the :index view" do
      expect(@response).to render_template :index
    end
  end

  describe "GET #show" do
    login_user :staff_user

    before :each do
      @opportunity = FactoryGirl.create(:opportunity)
      @response = get :show, id: @opportunity
    end

    it "assigns the requested opportunity to @opportunity" do
      expect(assigns(:opportunity)).to eq(@opportunity)
    end
    it "renders the :show template" do
      expect(@response).to render_template :show
    end
  end

  describe "GET #new" do
    login_user :marketing_user

    before :each do
      @response = get :new
    end
    it "assigns a new opportunity to @opportunity" do
      expect(assigns(:opportunity)).to be_a_new(Opportunity)
    end
    it "renders the :new template" do
      expect(@response).to render_template :new
    end
  end

  describe "POST 'create'" do
    login_user :marketing_user

    context "with valid attributes" do
      it "creates an opportunity" do
        expect{
          post :create, opportunity: build_attributes(:opportunity)
        }.to change(Opportunity, :count).by(1)
      end

      it "redirects to opportunity#new" do
        post :create, opportunity: build_attributes(:opportunity)
        expect(response).to redirect_to Opportunity.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new opportunity in the database" do
        expect{
          post :create, opportunity: FactoryGirl.attributes_for(:opportunity, title: nil)
        }.to_not change(Opportunity,:count)
      end
      it "re-renders the :new template" do
        post :create, opportunity: FactoryGirl.attributes_for(:opportunity, title: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    login_user :marketing_user

    before :each do
      @opportunity = FactoryGirl.create(:opportunity, title: 'opportunity 1', description: 'opportunity desc')
    end

    context "valid attributes" do
      it "locates the requested @opportunity" do
        put :update, id: @opportunity, opportunity: FactoryGirl.attributes_for(:opportunity)
        expect(assigns(:opportunity)).to eq(@opportunity)
      end

      it "changes @opportunity's attributes" do
        put :update, id: @opportunity,
            opportunity: FactoryGirl.attributes_for(:opportunity, title: "opportunity 2", description: 'desc opportunity')
        @opportunity.reload
        expect(@opportunity.title).to eq("opportunity 2")
        expect(@opportunity.description).to eq("desc opportunity")
        # expect(@opportunity.attachment).to eq('test2.pdf')
      end

      it "redirects to the updated opportunity" do
        put :update, id: @opportunity, opportunity: FactoryGirl.attributes_for(:opportunity)
        expect(response).to redirect_to @opportunity
      end
    end

    context "invalid attributes" do
      it "locates the requested @opportunity" do
        put :update, id: @opportunity, opportunity: FactoryGirl.attributes_for(:opportunity, title: nil)
        expect(assigns(:opportunity)).to eq(@opportunity)
      end

      it "does not change @opportunity's attributes" do
        put :update, id: @opportunity,
            opportunity: FactoryGirl.attributes_for(:opportunity, title: nil)
        @opportunity.reload
        expect(@opportunity.title).to eq("opportunity 1")
        expect(@opportunity.description).to eq("opportunity desc")
        expect(@opportunity.attachment_file_name).to eq('test.pdf')
      end

      it "re-renders the edit method" do
        put :update, id: @opportunity, opportunity: FactoryGirl.attributes_for(:opportunity, title: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    login_user :marketing_user

    before :each do
      @opportunity = FactoryGirl.create(:opportunity)
    end

    it "deletes an opportunity" do
      expect{
        delete :destroy, :id => @opportunity
      }.to change(Opportunity, :count).by(-1)
    end

    it "redirects to opportunitys#index" do
      delete :destroy, :id => @opportunity
      expect(response).to redirect_to opportunities_url
    end
  end

end
