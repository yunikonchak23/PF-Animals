class Tag < ApplicationRecord
  has_many :tag_middles, dependent: :destroy, foreign_key: 'tag_id'
  has_many :diaries, through: :tag_middles
end
