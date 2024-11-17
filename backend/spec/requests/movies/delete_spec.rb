# frozen_string_literal: true

RSpec.describe 'Movies API' do
  include_context 'with authenticated headers and user'

  path '/movies/{id}' do
    delete 'Create Movies' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string

      #  setup

      response '202', 'Accepted' do
        let(:movie) { create(:movie, uploader: authenticated_user) }

        let(:id) { movie.id }

        run_test! 'No movie' do
          expect do
            Movie.find(movie.id)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      response '403', 'Forbidden' do
        let(:uploader) { create(:user) }
        let(:movie) { create(:movie, uploader: uploader) }

        let(:id) { movie.id }

        run_test! 'response error' do
          expect(response_hash[:code]).to eq('FORBIDDEN')
          expect(response_hash[:type]).to eq('UNCATEGORY')
        end
      end

      response '202', 'For Admin' do
        let(:uploader) { create(:user) }
        let(:movie) { create(:movie, uploader: uploader) }

        let(:id) { movie.id }

        before do
          authenticated_user.admin!
        end

        run_test! 'No movie' do
          expect do
            Movie.find(movie.id)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
