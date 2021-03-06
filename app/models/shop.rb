class Shop < ApplicationRecord
  # :addressを登録した際にgeocoderが緯度、経度のカラムにも自動的に値を入れてくれるようになる。
  # この記述がないとaddressを登録してもlatitude(緯度),longitude(経度)が登録されなくなってしまう(nillになる)ので注意。
  geocoded_by :address
  after_validation :geocode

  belongs_to :genre
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # 写真の複数投稿
  has_many :shop_images, dependent: :destroy
  accepts_attachments_for :shop_images, attachment: :shop_image

  # 空欄ではないか
  validates :name, :introduction, :address, :genre_id, :phone_number,
            :station, :home_page, :holiday, presence: true

  # 一意性があるか
  validates :name, :address, :phone_number, uniqueness: true
  # 長くなりすぎないようにするために最大200文字に指定
  validates :introduction, length: { maximum: 200 }
  # 日本一長い駅名が22文字のため
  validates :station, length: { maximum: 22 }
  # 携帯電話の番号が11文字のため、最大11桁に指定
  validates :phone_number, length: { maximum: 11 }
  # 数字のみ入力可能
  validates :phone_number, numericality: { only_integer: true }

  # 投稿したカフェデータをuser側では「掲載許可」のみを表示させたいので記載
  enum is_active: { "申請中": 0, "掲載許可": 1, "掲載禁止": 2 }

  # user側のshop/show.htmlにて使用
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # どのselectにデータが入っているかを確認する
  # self, クラスメソッド化することで、searchコントローラーで使用することができる
  def self.distinguish_select(params)
    # 「真(true)」となった場合に実行したい処理 if 条件式
    select = params[:select1] if (params[:select1]).present?
    select = params[:select2] if (params[:select2]).present?
    select = params[:select3] if (params[:select3]).present?
    select = params[:select4] if (params[:select4]).present?
    select = params[:select5] if (params[:select5]).present?
    select = params[:select6] if (params[:select6]).present?
    select = params[:select7] if (params[:select7]).present?
    select = params[:select8] if (params[:select8]).present?
    select = params[:select9] if (params[:select9]).present?
    select = params[:select10] if (params[:select10]).present?
    select = params[:select11] if (params[:select11]).present?
    select = params[:select12] if (params[:select12]).present?
    select = params[:select13] if (params[:select13]).present?
    select = params[:select14] if (params[:select14]).present?
    select = params[:select15] if (params[:select15]).present?
    select = params[:select16] if (params[:select16]).present?
    select
  end

  # ↓この書き方で検索することも可能らしい
  # wheres = []
  # params[:addresses].each do |address|
  #   wheres << ["address LIKE ?", "%#{address}%"]
  # end
  # Shop.wehre(wheres)


  # コントローラーで受け取った値をここで検索する
  def self.search(select, genre)
    # 大阪府
    # 大阪市
    if select == 'o-kita'
      Shop.where(['address LIKE ?', '%大阪市北区%'])
    elsif select == 'toshima'
      Shop.where(['address LIKE ?', '%豊島区%'])
    elsif select == 'fukushima'
      Shop.where(['address LIKE ?', '%福島区%'])
    elsif select == 'konohana'
      Shop.where(['address LIKE ?', '%此花区%'])
    elsif select == 'o-tyuuou'
      Shop.where(['address LIKE ?', '%大阪市中央区%'])
    elsif select == 'o-nisi'
      Shop.where(['address LIKE ?', '%大阪市西区%'])
    elsif select == 'minato'
      Shop.where(['address LIKE ?', '%港区%'])
    elsif select == 'taishou'
      Shop.where(['address LIKE ?', '%大正区%'])
    elsif select == 'tennouji'
      Shop.where(['address LIKE ?', '%天王寺区%'])
    elsif select == 'naniwa'
      Shop.where(['address LIKE ?', '%浪速区%'])
    elsif select == 'nishiyodogawa'
      Shop.where(['address LIKE ?', '%西淀川区%'])
    elsif select == 'yodogawa'
      Shop.where(['address LIKE ?', '%淀川区%'])
    elsif select == 'higashiyodogawa'
      Shop.where(['address LIKE ?', '%東淀川区%'])
    elsif select == 'higasinari'
      Shop.where(['address LIKE ?', '%東成区%'])
    elsif select == 'ikuno'
      Shop.where(['address LIKE ?', '%生野区%'])
    elsif select == 'asahi'
      Shop.where(['address LIKE ?', '%旭区%'])
    elsif select == 'joutou'
      Shop.where(['address LIKE ?', '%城東区%'])
    elsif select == 'turumi'
      Shop.where(['address LIKE ?', '%鶴見区%'])
    elsif select == 'abeno'
      Shop.where(['address LIKE ?', '%阿倍野区%'])
    elsif select == 'suminoe'
      Shop.where(['address LIKE ?', '%住之江区%'])
    elsif select == 'sumiyoshi'
      Shop.where(['address LIKE ?', '%住吉区%'])
    elsif select == 'higashisuminoe'
      Shop.where(['address LIKE ?', '%東住之江区%'])
    elsif select == 'higashisumiyoshi'
      Shop.where(['address LIKE ?', '%東住吉区%'])
    elsif select == 'hirano'
      Shop.where(['address LIKE ?', '%平野区%'])
    elsif select == 'nishinari'
      Shop.where(['address LIKE ?', '%西成区%'])
    # 堺市
    elsif select == 'sakai'
      Shop.where(['address LIKE ?', '%堺区%'])
    elsif select == 'o-s-naka'
      Shop.where(['address LIKE ?', '%堺市中区%'])
    elsif select == 'o-s-higasi'
      Shop.where(['address LIKE ?', '%堺市東区%'])
    elsif select == 'o-s-nishi'
      Shop.where(['address LIKE ?', '%堺市西区%'])
    elsif select == 'o-s-minami'
      Shop.where(['address LIKE ?', '%堺市南区%'])
    elsif select == 'o-s-kita'
      Shop.where(['address LIKE ?', '%堺市北区%'])
    elsif select == 'mihara'
      Shop.where(['address LIKE ?', '%美原区%'])
    # 豊能地域
    elsif select == 'nose'
      Shop.where(['address LIKE ?', '%能勢町%'])
    elsif select == 'toyono'
      Shop.where(['address LIKE ?', '%豊能町%'])
    elsif select == 'ikeda'
      Shop.where(['address LIKE ?', '%池田市%'])
    elsif select == 'minou'
      Shop.where(['address LIKE ?', '%箕面市%'])
    elsif select == 'toyonaka'
      Shop.where(['address LIKE ?', '%豊中市%'])
    # 三島地域
    elsif select == 'ibaraki'
      Shop.where(['address LIKE ?', '%茨木市%'])
    elsif select == 'takatsuki'
      Shop.where(['address LIKE ?', '%高槻市%'])
    elsif select == 'shimamoto'
      Shop.where(['address LIKE ?', '%島本町%'])
    elsif select == 'suita'
      Shop.where(['address LIKE ?', '%吹田市%'])
    elsif select == 'settu'
      Shop.where(['address LIKE ?', '%摂津市%'])
    # 北河内地域
    elsif select == 'hirakata'
      Shop.where(['address LIKE ?', '%枚方市%'])
    elsif select == 'katano'
      Shop.where(['address LIKE ?', '%交野市%'])
    elsif select == 'neyagawa'
      Shop.where(['address LIKE ?', '%寝屋川市%'])
    elsif select == 'moriguchi'
      Shop.where(['address LIKE ?', '%守口市%'])
    elsif select == 'kadoma'
      Shop.where(['address LIKE ?', '%門真市%'])
    elsif select == 'shijounawate'
      Shop.where(['address LIKE ?', '%四條畷市%'])
    elsif select == 'daitou'
      Shop.where(['address LIKE ?', '%大東市%'])
    # 中河内地域
    elsif select == 'higashiosaka'
      Shop.where(['address LIKE ?', '%東大阪市%'])
    elsif select == 'yao'
      Shop.where(['address LIKE ?', '%八尾市%'])
    elsif select == 'kashiwara'
      Shop.where(['address LIKE ?', '%柏原市%'])
    # 泉北地域
    elsif select == 'izumi'
      Shop.where(['address LIKE ?', '%和泉市%'])
    elsif select == 'takaishi'
      Shop.where(['address LIKE ?', '%高石市%'])
    elsif select == 'izumiotsu'
      Shop.where(['address LIKE ?', '%泉大津市%'])
    elsif select == 'tadooka'
      Shop.where(['address LIKE ?', '%忠岡市%'])
    # 泉南地域
    elsif select == 'kishiwada'
      Shop.where(['address LIKE ?', '%岸和田市%'])
    elsif select == 'kaizuka'
      Shop.where(['address LIKE ?', '%貝塚市%'])
    elsif select == 'kumatori'
      Shop.where(['address LIKE ?', '%熊取町%'])
    elsif select == 'izumisano'
      Shop.where(['address LIKE ?', '%泉佐野市%'])
    elsif select == 'tajiri'
      Shop.where(['address LIKE ?', '%田尻町%'])
    elsif select == 'sennan'
      Shop.where(['address LIKE ?', '%泉南市%'])
    elsif select == 'hannan'
      Shop.where(['address LIKE ?', '%阪南市%'])
    elsif select == 'misaki'
      Shop.where(['address LIKE ?', '%岬町%'])
    # 南河内地域
    elsif select == 'matsubara'
      Shop.where(['address LIKE ?', '%松原市%'])
    elsif select == 'habikino'
      Shop.where(['address LIKE ?', '%羽曳野市%'])
    elsif select == 'fujidera'
      Shop.where(['address LIKE ?', '%藤井寺市%'])
    elsif select == 'taishi'
      Shop.where(['address LIKE ?', '%太子町%'])
    elsif select == 'kanan'
      Shop.where(['address LIKE ?', '%河南町%'])
    elsif select == 'tihayaakasaka'
      Shop.where(['address LIKE ?', '%千早赤阪村%'])
    elsif select == 'tondabayashi'
      Shop.where(['address LIKE ?', '%富田林市%'])
    elsif select == 'sayama'
      Shop.where(['address LIKE ?', '%狭山市%'])
    elsif select == 'kawachinagano'
      Shop.where(['address LIKE ?', '%河内長野市%'])

    # 京都府
    # 京都市
    elsif select == 'k-kita'
      Shop.where(['address LIKE ?', '%京都市北区%'])
    elsif select == 'kamigyou'
      Shop.where(['address LIKE ?', '%上京区%'])
    elsif select == 'sakyou'
      Shop.where(['address LIKE ?', '%左京区%'])
    elsif select == 'nakagyou'
      Shop.where(['address LIKE ?', '%中京区%'])
    elsif select == 'higashiyama'
      Shop.where(['address LIKE ?', '%東山区%'])
    elsif select == 'simogyou'
      Shop.where(['address LIKE ?', '%下京区%'])
    elsif select == 'k-minami'
      Shop.where(['address LIKE ?', '%京都市南区%'])
    elsif select == 'ukyou'
      Shop.where(['address LIKE ?', '%右京区%'])
    elsif select == 'fushimi'
      Shop.where(['address LIKE ?', '%伏見区%'])
    elsif select == 'yamashina'
      Shop.where(['address LIKE ?', '%山科区%'])
    elsif select == 'nishikyou'
      Shop.where(['address LIKE ?', '%西京区%'])
    # 乙訓地域
    elsif select == 'mukou'
      Shop.where(['address LIKE ?', '%向日市%'])
    elsif select == 'nagaokakyou'
      Shop.where(['address LIKE ?', '%長岡京市%'])
    elsif select == 'otokumi'
      Shop.where(['address LIKE ?', '%乙訓群%'])
    elsif select == 'oyamasaki'
      Shop.where(['address LIKE ?', '%大山崎町%'])
    # 山城中部地域
    elsif select == 'uji'
      Shop.where(['address LIKE ?', '%宇治市%'])
    elsif select == 'jouyou'
      Shop.where(['address LIKE ?', '%城陽市%'])
    elsif select == 'hachiman'
      Shop.where(['address LIKE ?', '%八幡市%'])
    elsif select == 'kyoutanabe'
      Shop.where(['address LIKE ?', '%京田辺市%'])
    elsif select == 'kuse'
      Shop.where(['address LIKE ?', '%久世郡%'])
    elsif select == 'kumiyama'
      Shop.where(['address LIKE ?', '%久御山町%'])
    elsif select == 'tuduki'
      Shop.where(['address LIKE ?', '%綴喜郡%'])
    elsif select == 'ide'
      Shop.where(['address LIKE ?', '%井手町%'])
    elsif select == 'ujitawara'
      Shop.where(['address LIKE ?', '%宇治田原町%'])
    # 相良地域
    elsif select == 'kidugawa'
      Shop.where(['address LIKE ?', '%木津川市%'])
    elsif select == 'sagara'
      Shop.where(['address LIKE ?', '%相良群%'])
    elsif select == 'kasagi'
      Shop.where(['address LIKE ?', '%笠置町%'])
    elsif select == 'waduka'
      Shop.where(['address LIKE ?', '%和束長%'])
    elsif select == 'seika'
      Shop.where(['address LIKE ?', '%精華町%'])
    elsif select == 'minamiyamashiro'
      Shop.where(['address LIKE ?', '%南山城町%'])
    # 中部地域
    elsif select == 'kameoka'
      Shop.where(['address LIKE ?', '%亀岡市%'])
    elsif select == 'nantan'
      Shop.where(['address LIKE ?', '%南丹市%'])
    elsif select == 'funai'
      Shop.where(['address LIKE ?', '%船井郡%'])
    elsif select == 'kyoutanba'
      Shop.where(['address LIKE ?', '%京丹波町%'])
    # 中丹地域
    elsif select == 'fukuchiyama'
      Shop.where(['address LIKE ?', '%福知山市%'])
    elsif select == 'maiduru'
      Shop.where(['address LIKE ?', '%舞鶴市%'])
    elsif select == 'ayabe'
      Shop.where(['address LIKE ?', '%綾部市%'])
    # 丹後地域
    elsif select == 'miyadu'
      Shop.where(['address LIKE ?', '%宮津市%'])
    elsif select == 'kyoutango'
      Shop.where(['address LIKE ?', '%京丹後市%'])
    elsif select == 'yosa'
      Shop.where(['address LIKE ?', '%与謝郡%'])
    elsif select == 'ine'
      Shop.where(['address LIKE ?', '%伊根町%'])
    elsif select == 'yosano'
      Shop.where(['address LIKE ?', '%与謝野町%'])
    elsif genre == genre
      Shop.where(['genre_id LIKE ?', genre.to_s])
    end
  end

  # Shop.where(["address LIKE ?", "%羽曳野市%"])
  #   elsif select == "fujidera"
  #     Shop.where(["address LIKE ?", "%藤井寺市%"])
  #   elsif select == "higashiosaka"
  #     Shop.where(["address LIKE ?", "%東大阪市%"])
  #   else
  #     Shop.where(["name LIKE ?", "%#{search}%"])
  #   end
end
