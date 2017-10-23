require 'rails_helper'

RSpec.describe 'Transfers API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:transfers) { create_list(:transfer, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { transfers.first.id }
  let(:auth_header) { authenticated_header(user) }

  # Test suite for GET /users/:user_id/transfers
  describe 'GET /users/:user_id/transfers' do
    describe 'authenticated_hear' do
      before { get "/users/#{user_id}/transfers", headers: auth_header}

      context 'when user exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns all user transfers' do
          expect(json.size).to eq(10)
        end
      end

      context 'when user does not exist' do
        let(:user_id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find User with/)
        end
      end

      context 'when user_id does not match token' do
        let(:user_id) { user2.id }

        it 'returns status code 401' do
          expect(response).to have_http_status(401)
        end
      end
    end

    describe 'unauthenticated_header' do
      before { get "/users/#{user_id}/transfers", headers: unauthenticated_header}
      
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for GET /users/:user_id/transfers/:id
  describe 'GET /users/:user_id/transfers/:id' do
    before { get "/users/#{user_id}/transfers/#{id}", headers: auth_header }

    context 'when user transfer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the transfer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(nil)
      end
    end

    context 'when user transfer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Transfer/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/transfers
  describe 'POST /users/:user_id/transfers' do
    let(:valid_attributes) do
      {   
        account_number_from: Faker::Number.number(18),
        account_number_to: Faker::Number.number(18),
        amount_pennies: Faker::Number.between(10, 100),
        country_code_from: 'GBR',
        country_code_to: 'GBR' 
      }
    end

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/transfers", params: valid_attributes, headers: auth_header }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/transfers", params: {account_number_from: '00'}, headers: auth_header }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Account number from is the wrong length/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/transfers/:id
  describe 'PUT /users/:user_id/transfers/:id' do
    let(:valid_attributes) do 
      { 
        account_number_from: '000000000000000001',
        account_number_to: '000000000000000002',
      }
    end

    before { put "/users/#{user_id}/transfers/#{id}", params: valid_attributes, headers: auth_header }

    context 'when transfer exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the transfer' do
        updated_transfer = Transfer.find(id)
        expect(updated_transfer.account_number_from).to match(/000000000000000001/)
        expect(updated_transfer.account_number_to).to match(/000000000000000002/)
      end
    end

    context 'when the transfer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Transfer/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/transfers/#{id}", headers: auth_header }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
