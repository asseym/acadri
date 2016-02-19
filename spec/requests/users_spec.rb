require 'rails_helper'
include ActionView::Helpers::UrlHelper

RSpec.describe "Users", type: :request do
  describe "User Management" do
    login_user :superadmin
    context "GET /users" do
      res_data = attrs(:superadmin)

      it "gets users#index" do
        get users_path
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
        # expect(response.body).to include(res_data[:name])
      end

      it "creates a user and redirects to the users page" do
        get new_user_path
        expect(response).to render_template(:new)

        post users_path, :user => FactoryGirl.attributes_for(:ordinary_user)
        expect(response).to redirect_to users_path
        follow_redirect!
        # expect(response).to redirect_to(assigns(:user))
        # follow_redirect!
        expect(response).to render_template(:index)
        expect(User.count).to eq(2)
        within 'div.alert' do
          expect(response.body).to include("User was successfully created.")
        end
        within "a[href=#{url_for user_path(@user)}" do
          expect(response.body).to include(@user[:name])
        end
      end


    end
  end
end
