require 'rails_helper'

describe AuthorsController do
	describe 'POST #create' do
		context 'with valid attributes' do
			it 'creates the author' do
				post :create, author: attributes_for(:author)
				expect(Author.count).to eq(1)
			end

			it 'redirects to #show for the new author' do
				post :create, author: attributes_for(:author)
				expect(response).to redirect_to Author.first
			end
		end

		context 'with invalid attributes' do
			it 'does not create the vehicle' do
				post :create, author: attributes_for(:author, birth_date: Time.now)
				expect(Author.count).to eq(0)
			end

			it 'rerenders #new' do
				post :create, author: attributes_for(:author, birth_date: Time.now) 
				expect(response).to render_template :new
			end
		end
	end
end