require 'rails_helper'

RSpec.feature 'USER creates a booklist', type: :feature do

	let!(:book){create(:book)}
	let!(:user){create(:user)}
	let!(:list){create(:list, user: user)}
	let!(:review){create(:review, user: user, book: book)}

	scenario 'create booklist if user present' do
		sign_in user
		visit "books/#{book.id}"
		expect do
	 		select "#{list.name}", from: 'book_list_list_id'
			click_button "Добавить в список"
		end.to change(BookList, :count).by(1)
	end

	scenario 'create booklist if user empty' do
		visit "books/#{book.id}"
		expect(page.has_css?("#book_list_list_id")).to eq false
	end

	scenario 'delete review' do
		sign_in user
		visit "books/#{book.id}"
		expect{find("a[href='/books/#{book.id}/reviews/#{review.id}'][data-method='delete']").click}.to change(Review, :count).by(-1)
	end

	scenario 'edit review' do
		sign_in user
		visit "books/#{book.id}"
		expect do
			find("a[href='/books/#{book.id}/reviews/#{review.id}/edit']").click
			fill_in "review_body", with: "this is new text for review"
			select 3, from: 'review_rating'
			click_button "Редактировать отзыв"
			review.reload
		end.to change(review, :body).to("this is new text for review")
		.and change(review, :rating).to(3)
	end

	scenario 'create new review' do
		sign_in user
		visit "books/#{book.id}"
		expect do
			click_link "Написать отзыв"
			fill_in "review_body", with: "this is new text for review"
			select 5, from: 'review_rating'
			click_button "Оставить отзыв"
			#Review.reload
		end.to change(Review, :count).by(1) and
		expect(Review.last.body).to eq("this is new text for review") and
		expect(Review.last.rating).to eq(5)
	end
end
