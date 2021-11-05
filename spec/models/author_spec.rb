require 'rails_helper'
describe Author do 
	context "validation" do 
		it "valid author" do 
			author = build(:author)
			expect(author).to be_valid
		end
		it "valid name not nil" do 
			author = build(:author, name: nil)
			expect(author).to_not be_valid
		end
		it "valid uniq" do 
			create(:author, name: "test")
			author = build(:author, name: "test")
			expect(author).to_not be_valid
		end
	end
end