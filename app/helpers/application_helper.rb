module ApplicationHelper
  def user_has_rights?(user)
    current_user == user
  end

  def form_errors_for(object = nil)
    render("shared/form_errors", object: object) #if object.present?
  end
  
end
