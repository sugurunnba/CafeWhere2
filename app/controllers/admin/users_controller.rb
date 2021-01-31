class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!,


  def leave
    @users = User.page(params[:page]).reverse_order
  end

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :gender, :phone_number, :address, :user_status)
  end
end
