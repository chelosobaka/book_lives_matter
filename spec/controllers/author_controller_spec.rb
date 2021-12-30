require 'rails_helper'
describe AuthorsController, type: :controller do 
	#let(:author){create(:author)}
	it 'GET show' do 
		author = create(:author)
		get 'show', params: { id: author.id } 
		expect(response.status).to eq(200)
	end
end