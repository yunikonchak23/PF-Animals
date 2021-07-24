class Diary < ApplicationRecord
  belongs_to :pet
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_diaries, through: :bookmarks, source: :diary
  has_many :tag_middles, dependent: :destroy
  has_many :tags, through: :tag_middles

  validates :diary_title, presence: true, length: { minimum: 2}
  validates :diary_body, presence: true

  attachment :diary_image

  # 引数で渡されたユーザidがFavoritesテーブル内に存在するかどうか。
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # 引数で渡されたユーザidがBookmarksテーブル内に存在するかどうか。
  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  # tag機能
  def save_tag(sent_tags)
    #createで保存したdiaryに紐付いているタグを「タグの名前を配列として」全て取得。
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    #取得したdiaryに存在するタグから、送信されてきたタグを除いたタグをold_tagsとする。
    old_tags = current_tags - sent_tags
    #送信されてきたタグから、現在存在するタグを除いたタグをnew_tagsとする。
    new_tags = sent_tags - current_tags

    #古いタグの削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    #新しいタグをデータベースに保存
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tag
    end
  end
end
