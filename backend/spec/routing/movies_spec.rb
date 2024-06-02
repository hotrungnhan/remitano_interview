# frozen_string_literal: true

RSpec.describe MoviesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/movies').to route_to('movies#index')
    end

    it 'routes to #create' do
      expect(post: 'api/movies').to route_to('movies#create')
    end
  end
end
