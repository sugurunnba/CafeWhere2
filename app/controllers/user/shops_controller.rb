class User::ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
    @shop.shop_images.new
    @genres = Genre.all
  end

  def create
    @user = current_user
    @shop = Shop.new(shop_params)

    # time_selectを使うと年月日を登録しないといけないが、このアプリでは年の登録をしていないため、自動的に西暦1年で登録されてしまい、LMTになってしまう。
    # LMTで登録した時間を上書きして表示させるため、下記を記載, 2000は西暦を上書きしている
    s_time = Time.zone.local(2000, shop_params["start_business_hours(2i)"], shop_params["start_business_hours(3i)"],
                             shop_params["start_business_hours(4i)"], shop_params["start_business_hours(5i)"])
    f_time = Time.zone.local(2000, shop_params["finish_business_hours(2i)"], shop_params["finish_business_hours(3i)"],
                             shop_params["finish_business_hours(4i)"], shop_params["finish_business_hours(5i)"])

    @shop.start_business_hours = s_time
    @shop.finish_business_hours = f_time

    @genres = Genre.all
    if @shop.save
      flash[:success] = "リクエスト頂きありがとうございます！"
      redirect_to user_user_path(current_user)
    else
      render :new
    end
  end

  def index
    @shops = Shop.page(params[:page]).reverse_order
  end

  def show
    @shop = Shop.find(params[:id])
    @user = current_user
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :introduction, :address, :genre_id, :start_business_hours,
                                 :finish_business_hours, :station, :phone_number, :home_page, :holiday, :longitude, :latitude, shop_images_shop_images: [])
  end
end
