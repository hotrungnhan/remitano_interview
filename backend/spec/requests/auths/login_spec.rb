# frozen_string_literal: true

RSpec.describe 'Auths API' do
  path '/auths/login' do
    post 'Login' do
      tags 'Auths'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: Validations::Auths::Login.json_schema

      response '200', 'Success' do
        let(:user) { create(:user, password: password) }
        let(:password) { '123456' }

        let(:params) do
          {
            email: user.email,
            password: user.password
          }
        end

        run_test! 'return user access token' do
          expect(response_hash[:data]).to include(:access_token)
        end
      end

      response '400', 'Missing password Error' do
        let(:user) { create(:user) }

        let(:params) do
          {
            email: user.email
          }
        end

        run_test! 'return error' do
          expect(response_hash[:data]).to include(:access_token)
        end
      end
    end
  end
end
