class User::UsersController < ApplicationController
  def top
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_user_path(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :introduction, :gender, :phone_number, :address)
  end

end
