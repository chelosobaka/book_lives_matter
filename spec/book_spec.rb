require 'rails_helper'
describe Book, '#mean_rating' do
	it 'return mean rating' do

		user = create(:user)
		book = create(:book)
		review = create(:review1)
		#book.reviews.each do |review|
			#puts review.text
		#end

	end
end

describe Book, '.create_all' do
end
