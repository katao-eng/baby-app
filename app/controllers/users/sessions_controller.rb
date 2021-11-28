# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    cookies.delete :baby_id
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def guest_sign_in
    cookies.delete :baby_id
    user = User.find_or_create_by!(email: 'guest@email.com') do |user|
      user.password = SecureRandom.alphanumeric
      user.relationship_id = 0
    end
    sign_in user
    redirect_to guest_baby_create_babies_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
