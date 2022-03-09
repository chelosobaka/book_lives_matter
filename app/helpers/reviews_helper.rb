module ReviewsHelper
	def your_review_title(user)
		if current_user == user 
			"Ваши отзывы"
		else 
		  "Отзывы #{user.username}" 
		end
	end
end
