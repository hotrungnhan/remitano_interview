# frozen_string_literal: true

RSpec.describe MoviesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/movies').to route_to('movies#index')
    end

    it 'routes to #show' do
      expect(get: 'api/v1/movies/123').to route_to('movies#show', id: '123')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/v1/movies/123').to route_to('movies#destroy', id: '123')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/movies').to route_to('movies#create')
    end

    it 'routes to #react' do
      expect(post: 'api/v1/movies/123/react').to route_to('movies#react', id: '123')
    end
  end
end
