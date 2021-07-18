class Diary < ApplicationRecord
  belongs_to :pet
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_middles, dependent: :destroy
  has_many :tags, through: :tag_middles

  validates :diary_title, presence: true, length: { minimum: 2}
  validates :diary_body, presence: true

  attachment :diary_image

  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうか。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # tag機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.diary_tags.delete DiaryTag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_diary_tag = DiaryTag.find_or_create_by(tag_name: new)
      self.diary_tags << new_diary_tag
    end
  end
end
