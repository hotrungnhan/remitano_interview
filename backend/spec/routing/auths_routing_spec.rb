require "rails_helper"

RSpec.describe AuthsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/auths").to route_to("auths#index")
    end

    it "routes to #show" do
      expect(get: "/auths/1").to route_to("auths#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/auths").to route_to("auths#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/auths/1").to route_to("auths#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/auths/1").to route_to("auths#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/auths/1").to route_to("auths#destroy", id: "1")
    end
  end
end
