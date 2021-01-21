class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: "User"
  belongs_to :subscription, foreign_key: :followed_user_id, class_name: "User"

  validates_uniqueness_of :followed_user_id, scope: :follower_id
  validate :subscribed_to_yourself

  def subscribed_to_yourself
    if followed_user_id == follower_id
      errors.add(:followed_user_id, "You can not subscribed to yourself")
    end
  end
end
