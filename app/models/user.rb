class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :pets, dependent: :destroy
  attachment :image
 
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
