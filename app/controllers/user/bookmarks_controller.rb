class User::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).reverse_order
  end

  def create
    @user = current_user
    @shop = Shop.find(params[:shop_id])
    bookmark = Bookmark.new(user_id: current_user.id, shop_id: @shop.id)
    bookmark.save
    flash[:success] = 'ブックマークしました'
  end

  def destroy
    @user = current_user
    @shop = Shop.find(params[:shop_id])
    bookmark = @shop.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy
    flash[:success] = 'ブックマークを外しました'
  end
end
