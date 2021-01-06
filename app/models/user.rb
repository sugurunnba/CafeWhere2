class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enumがなくても登録できている、必要か分からないためコメントアウトにしている
  # enum gender: {"男性": 1, "女性": 2}

  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy

end
