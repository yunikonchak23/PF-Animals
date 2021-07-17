class Diary < ApplicationRecord
  belongs_to :pet
  has_many :comments, dependent: :destroy
  attachment :diary_image
end
