require 'rails_helper'
describe List do 
	context "validation" do 
		let(:some_user){ create(:user) }
		it "not valid user" do 
			list = List.create(name: "test")
			expect(list).to_not be_valid
		end

		it "valid presence name" do 
			list = List.create(user: some_user, name: "test name")
			expect(list).to be_valid
		end

		it "not valid presence name" do 
			list = List.create(user: some_user, name: nil)
			expect(list).to_not be_valid
		end

		it "not valid name length" do 
			list = List.create(user: some_user, name: "t")
			expect(list).to_not be_valid
		end

		it "not valid presence name" do 
			list = List.create(user: some_user, name: "ttttttttttttttttttttttttttttest")#31
			expect(list).to_not be_valid
		end

		it "not valid uniq name" do 
			list1 = List.create(user: some_user, name: "test name")
			list2 = List.create(user: some_user, name: "test name")
			expect(list2).to_not be_valid
		end

		it "valid uniq name" do 
			user2 = create(:user)
			list1 = List.create(user: some_user, name: "test name")
			list2 = List.create(user: user2, name: "test name")
			expect(list2).to be_valid
		end
	end        
end

  #validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 30}
  #validates :user, presence: true