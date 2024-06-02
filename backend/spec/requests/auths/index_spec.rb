# frozen_string_literal: true

RSpec.describe 'Auths API' do
  include_context 'with authenticated headers and user'
  path '/auths' do
    get 'Get Current User Data' do
      tags 'Auths'

      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Success' do
        run_test!
        it do
          expect(response_hash[:data]).to include(:id, :email, :created_at, :updated_at)
        end
      end
    end
  end
end
