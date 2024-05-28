RSpec.describe AuthsController do
  describe 'routing' do
    it 'routes to #login' do
      expect(post: '/auths/login').to route_to('auths#login')
    end

    it 'routes to #register' do
      expect(post: '/auths/register').to route_to('auths#register')
    end
  end
end
