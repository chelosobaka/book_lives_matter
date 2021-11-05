
require 'rails_helper'
describe Book do
	context "validation" do 
		let(:book1) { create(:book, isbn: 1, lb_id: 1) }

		it "not valid duplicate isbn" do 
			book1
			duplicate = Book.new(isbn: 1)
			expect(duplicate.valid?).to be_falsy
		end
		it "valid not duplicate isbn" do 
			book1
			duplicate = Book.new(isbn: 2)
			expect(duplicate.valid?).to be_truthy
		end
		it "not valid duplicate lb_id" do 
			book1
			duplicate = Book.new(lb_id: 1)
			expect(duplicate.valid?).to be_falsy
		end
		it "valid not duplicate lb_id" do 
			book1
			duplicate = Book.new(lb_id: 2)
			expect(duplicate.valid?).to be_truthy
		end
	end

	context "average_rating" do
		it 'average rating when > 0' do
			book = create(:book_with_reviews)
			sum = 0
			book.reviews.each do |review|
				sum += review.rating
			end
			avg = (sum.to_f / book.reviews.count).round(1)
			expect(book.average_rating).to eq avg
		end

		it 'average rating when no reviews' do
			book = create(:book)
			expect(book.average_rating).to eq 0
		end
	end
end


