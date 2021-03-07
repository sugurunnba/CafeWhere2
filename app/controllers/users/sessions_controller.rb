# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # 退会機能時に追加↓
  before_action :reject_inactive_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # 退会機能時に追加↓
  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    redirect_to new_user_session_path if @user && @user.valid_password?(params[:user][:password]) && @user.user_status
  end

  # ゲストログイン機能次に追加↓
  def new_guest
    user = User.guest
    sign_in user
    flash[:success] = "ゲストユーザーとしてログインしました。"
    redirect_to user_path(user)
  end
end
