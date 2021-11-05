require 'rails_helper'
describe User do 
	context "validation" do 
		it "valid username" do 
			user = build(:user)
			expect(user).to be_truthy
		end
		it "not valid username" do 
			user = build(:user, username: "")
			expect(user).to_not be_valid
		end
		it "valid email" do 
			user = build(:user)
			expect(user).to be_valid
		end
		it "not valid email1" do 
			user = build(:user, email: "testmail.ru")
			expect(user).to_not be_valid
		end
		it "not valid email2" do 
			user = build(:user, email: "test@mailru")
			expect(user).to_not be_valid
		end
	end

	context "follows" do 
		let(:followed_var){ create(:followed) }
		let(:follower_var){ create(:follower) }
		it "is following?" do
			fol = follower_var.follow(followed_var.id)
			expect(follower_var.following?(followed_var)).to be_truthy
		end

		it "is follower?" do 
			fol = followed_var.follow(follower_var.id)
			expect(follower_var.follower?(followed_var)).to be_truthy
		end
	end

end

