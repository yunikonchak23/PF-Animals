class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :question_title, presence: true, length: { minimum: 2, maximum: 50}
  validates :question_body, presence: true
end
