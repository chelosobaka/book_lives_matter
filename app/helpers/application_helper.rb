module ApplicationHelper
  def user_has_rights?(user)
    current_user == user
  end
end
