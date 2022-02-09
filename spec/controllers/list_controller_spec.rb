require 'rails_helper'

describe ListsController, type: :controller do
	
	describe "index" do 
		let!(:user){create(:user_with_lists_with_books)}

		it "test index" do
			get :index, {params: {user_id: user.id}}
			expect(assigns(:lists)).to eq user.lists
			expect(response).to have_http_status(200) 
		end
	end

	describe "show" do 
		let!(:user){create(:user)}
		let!(:list){create(:list_with_user_and_books, user_id: user.id)}
		before{get :show, {params: {user_id: user.id, id: list.id}}}

		it "test user" do 
			expect(assigns(:user)).to eq user
		end

		it 'test list' do
			expect(assigns(:list)).to eq list
		end

		it 'test response' do
			expect(response).to have_http_status(200) 
		end
	end

	describe "new" do 
		let!(:user){create(:user)}

		it "test new" do
			sign_in user
      get :new, {params: {user_id: user.id}}
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:new)
    end
	end

	describe "create" do 
		let!(:user){create(:user)}

		it "test List will change count by 1" do 
			sign_in user
			expect do
				post :create, {params: {list: attributes_for(:list), user_id: user.id}}
			end.to change(List, :count).by(1) 
		end

		it "test redirect to created object" do
			sign_in user
			post :create, {params: {list: attributes_for(:list), user_id: user.id}}
			expect(response).to redirect_to user_lists_path(user.id)
		end

		it "will render action new" do
			sign_in user
			post :create, {params: {list: {name: nil}, user_id: user.id}}
			expect(response).to render_template(:new)
		end
	end

	describe "update" do 
		let!(:user){create(:user)}
		let!(:list){create(:list, user: user)}

			it "will edit name list" do 
				sign_in user
				patch :update, {params: {user_id: list.user.id, id: list.id, list: {name: "test"}}}
				list.reload
				expect(assigns(:list).name).to eq("test")
			end

			it "will redirect if success" do 
				sign_in user
				patch :update, {params: {user_id: list.user.id, id: list.id, list: {name: "test"}}}
				expect(response).to redirect_to user_lists_path(user.id)
			end

			it "will redirect to action edit" do 
				sign_in user
				patch :update, {params: {user_id: list.user.id, id: list.id, list: {name: ""}}}
				expect(response).to render_template(:edit)
			end
	end

	describe "delete" do 
		let!(:user){create(:user)}
		let!(:list){create(:list, user: user)}

		it "wil delete list" do 
			sign_in user
			expect do 
				delete :destroy, {params: {user_id: list.user.id, id: list.id}}
			end.to change(List, :count).by(-1)
		end

		it "will redirect if success" do 
				sign_in user
				delete :destroy, {params: {user_id: list.user.id, id: list.id}}
				expect(response).to redirect_to user_lists_url(user.id)
			end
	end
end