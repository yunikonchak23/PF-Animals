class Pet < ApplicationRecord
  belongs_to :user
  has_many :diaries, dependent: :destroy
  attachment :image

  enum gender: {未選択:0,男の子:1,女の子:2,性別不明:3}
end
