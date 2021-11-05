require 'rails_helper'
describe Review do 
	context "validation" do 
		it "valid review" do 
			review = build(:review)
			expect(review).to be_valid
		end

		it "not valid user" do 
			review = build(:review, user: nil)
			expect(review).to_not be_valid
		end

		it "not valid body" do 
			review = build(:review, body: nil)
			expect(review).to_not be_valid
		end

		it "not valid length body" do 
			review = build(:review, body: "test")
			expect(review).to_not be_valid
		end

		it "not valid rating" do 
			review = build(:review, rating: 6)
			expect(review).to_not be_valid
		end

		it "not valid rating v2" do 
			review = build(:review, rating: -2)
			expect(review).to_not be_valid
		end
		
		it "not valid rating v3" do 
			review = build(:review, rating: 0)
			expect(review).to_not be_valid
		end
	end
end




  #validates :body, :user, presence: true
  #validates :body, length: {minimum: 10, maximum: 4000}
  #validates :rating, presence: true, inclusion: {in: RATING}