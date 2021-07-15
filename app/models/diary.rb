class Diary < ApplicationRecord
  belongs_to :pet
  attachment :diary_image
end
