class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :lists, dependent: :destroy
#подписчики
  has_many :follower_relationships, class_name: 'Follow', foreign_key: :followed_user_id
  has_many :followers, through: :follower_relationships
#подписки
  has_many :subscription_relationships, class_name: 'Follow', foreign_key: :follower_id
  has_many :subscriptions, through: :subscription_relationships


  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :username, :email, presence: true
  validates :email, uniqueness: true

  def follow(another_user_id)
    subscription_relationships.create(followed_user_id: another_user_id)
  end
 
  def unfollow(another_user_id)
    subscription_relationships.find_by(followed_user_id: another_user_id).destroy
  end

  def following?(another_user)
    subscriptions.include?(another_user)
  end

  def follower?(another_user)
    followers.include?(another_user)
  end

end
