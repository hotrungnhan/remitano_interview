# frozen_string_literal: true

RSpec.describe 'Auths API' do
  path '/auths/register' do
    post 'Register New User' do
      tags 'Auths'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: Validations::Auths::SignUp.json_schema

      response '200', 'Success' do
        let(:user) { create(:user, password: password) }
        let(:password) { '123456' }

        let(:params) do
          {
            email: Faker::Internet.email,
            password: password
          }
        end

        run_test! 'return user access token' do
          expect(response_hash[:data]).to include(:access_token)
          expect(User.count).to eq(1)
        end
      end
    end
  end
end
