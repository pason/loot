require 'rails_helper'

RSpec.describe 'UserToken API' do
  # Initialize the test data
  let!(:user) { create(:user) }

  describe 'POST /user_token' do
    let(:valid_attributes) { { auth: { username: user.username, password: '123456' } } }

    context 'when the request is valid' do
      before { post '/user_token', params: valid_attributes }

      it 'creates a token' do
        expect(json['jwt']).not_to be_empty 
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/user_token', params: { auth: { username: user.username, password: 'invalid' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
