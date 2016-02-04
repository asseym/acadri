class Users::PasswordsController < Devise::PasswordsController
  # # GET /resource/password/new
  # def new
  #   super
  # end
  #
  # # POST /resource/password
  # def create
  #   super
  # end
  #
  # # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end
  #
  # # PUT /resource/password
  # def update
  #   super
  # end
  #
  # protected
  #
  #   def after_resetting_password_path_for(resource)
  #     super(resource)
  #   end
  #
  #   # The path used after sending reset password instructions
  #   def after_sending_reset_password_instructions_path_for(resource_name)
  #     super do |resource_name|
  #       respond_to do |format|
  #         format.html { redirect_to new_user_session_path, notice: 'Instruction have been sent to your email for creating a new password, login with the new password below' }
  #         format.json { head :no_content }
  #       end
  #     end
  #   end
end
