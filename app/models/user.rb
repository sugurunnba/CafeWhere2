class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: "ゲストユーザー", gender: "男性", introduction: "ゲストユーザーです") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # enumがなくても登録できている、必要か分からないためコメントアウトにしている
  enum gender: { "男性": 1, "女性": 2 }

  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, :gender, :email, presence: true
  validates :name, uniqueness: true
  validates :introduction, length: { maximum: 100 }
end
