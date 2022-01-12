require 'rails_helper'

describe ListsController, type: :controller do
	
	context "index" do 
		let!(:user){create(:user_with_lists_with_books)}

		it "test index" do

			get :index, {params: {user_id: user.id}}
			expect(assigns(:lists)).to eq user.lists
		end
	end

	context "show" do 
		let!(:user){create(:user_with_list_with_books)}

		it "test show" do 

			get :show, {params: {user_id: user.id, id: list.id}}
			expect(assigns(:user)).to eq user
			expect(assigns(:list)).to eq list
		end

	end
end