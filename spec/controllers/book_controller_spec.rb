require 'rails_helper'

describe BooksController, type: :controller do
	
	context "index" do 
		let!(:book1){create_list(:book_with_author, 9)}
		let!(:book2){create_list(:book_with_author, 3, title: "test")}
		let!(:book3){create_list(:book_with_author, 3, title: "Test")}
		let!(:book4){create(:book_with_test_author)}

		it 'render index' do 
			get :index
			expect(response).to render_template("index")
		end

		it 'test params' do 
			get :index, {params: { :search => "TeSt"}}
			expect(controller.params[:search]).to eq "TeSt"
		end

		it 'GET index with search params by book' do
			get :index, {params: { :search => "Test"}}
			expect(assigns[:books].size).to eq 7
		end

		it 'GET index with search params by author' do
			get :index, {params: { :search => "Test Author"}}
			expect(assigns[:books].size).to eq 1
		end

		it 'GET index without surch search params' do
			get :index
			expect(assigns[:books].size).to eq 15
		end
	end	
	
	context "show" do 
		let!(:book){(create(:book))}
		let!(:book_with_reviews){(create(:book_with_reviews))}
		it 'render show' do 
			get :show, {params: {id: book.id}}
			expect(response).to render_template("show")
		end

		it 'book with coments' do 
			get :show, {params: {id: book_with_reviews.id}}
			expect(assigns(:reviews).size).to eq book_with_reviews.reviews.size
		end
	end
end