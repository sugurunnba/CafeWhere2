class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def new
    @genre = Genre.new
  end

  def index
    @genres = Genre.page(params[:page]).reverse_order
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = 'ジャンルを新規登録しました'
      redirect_to admin_genres_path
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = 'ジャンル名を更新しました'
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:success] = 'ジャンルを削除しました'
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
