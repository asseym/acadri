require 'rails_helper'

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

        expect(response).to redirect_to(assigns(:user))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("Widget was successfully created.")
        expect(response.body).to include(:user[:name])
      end
    end
  end
end
