module AdminHelper
  def new_object(model)
    case model
    when "authors"
      link_to("Новый автор", new_admin_author_path, class: "nav-link")
    when "books"
      link_to("Новая книга", new_admin_book_path, class: "nav-link")
    when "users"
      link_to("Новый пользователь", new_admin_user_path, class: "nav-link")
    end
  end
end
