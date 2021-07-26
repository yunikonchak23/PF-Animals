class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :pets,      dependent: :destroy
  has_many :diaries,   dependent: :destroy, through: :pets
  has_many :questions, dependent: :destroy
  has_many :answers,   dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_diaries, through: :bookmarks, source: :diary

  # 自身がフォローされる
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→followed_idをフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自身がフォローする
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→follower_idをフォローしている人
  has_many :followings, through: :relationships, source: :followed

　# 画像保存
  attachment :image

  # バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, uniqueness: true

  # フォロー機能 メソッド
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

  # 退会処理　is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
