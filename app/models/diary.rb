class Diary < ApplicationRecord
  belongs_to :pet
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :diary_title, presence: true, length: { minimum: 2}
  validates :diary_body, presence: true

  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうか。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  attachment :diary_image
end
