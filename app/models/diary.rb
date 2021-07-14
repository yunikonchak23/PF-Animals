class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :pets

  attachment :image
end
