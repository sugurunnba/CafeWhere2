class User::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @shop = Shop.find(params[:shop_id])
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @review = Review.new(review_params)
    # アソシエーションしている際、データを紐づけるために「_id」にidを入れる
    @review.user_id = current_user.id
    @review.shop_id = @shop.id
    if @review.save
      redirect_to shop_path(@shop)
      flash[:success] = '評価頂きありがとうございます！'
    else
      render :new
    end
  end

  def index
    @shops = Shop.joins(:reviews).group(:shop_id).order('avg(rate) DESC')
    # @shops = Shop.page(params[:page])
    # @shops = Shop.all
    # sort_by, 配列を小さい順に並べる
    # 「@変数名 { |〇〇| }」でeach doを１行にした簡略文を作成できる
    # モデル.average(カラム名), カラムの平均化
    # .to_f.round(N), 小数点以下N桁の四捨五入
    # @average_shops = @shops.sort_by { |shop| shop.reviews.average(:rate).to_f.round(1) }.reverse
    # @shops = @average_shops.page(params[:page])
    @average_shops = @shops
    @shops = @shops.page(params[:page])
  end

  def show
    @review = Review.find(params[:shop_id])
  end

  def edit
    @review = Review.find(params[:shop_id])
    @shop = Shop.find(params[:id])
  end

  def update
    shop = Shop.find(params[:shop_id])
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to shop_path(shop)
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    review = Review.find(params[:id])
    review.destroy
    redirect_to shop_path(shop)
  end

  def review_params
    params.require(:review).permit(:title, :body, :rate, :shop_id)
  end
end
