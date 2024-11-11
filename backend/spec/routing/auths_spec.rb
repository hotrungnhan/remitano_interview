# frozen_string_literal: true

RSpec.describe AuthsController do
  describe 'routing' do
    it 'routes to #login' do
      expect(post: 'api/auths/login').to route_to('auths#login')
    end

    it 'routes to #register' do
      expect(post: 'api/auths/register').to route_to('auths#register')
    end

    it 'routes to #index' do
      expect(get: 'api/auths').to route_to('auths#index')
    end
  end
end
