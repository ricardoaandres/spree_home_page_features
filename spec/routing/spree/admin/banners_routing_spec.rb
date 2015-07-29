require "spec_helper"

describe Spree::Admin::BannersController, :type => :routing do
  describe "routing" do
    routes { Spree::Core::Engine.routes }

    it "routes to #index" do
      expect(get "/admin/banners").to route_to(controller: "spree/admin/banners", action: 'index')
    end

    it "routes to #new" do
      expect(get "/admin/banners/new").to route_to(controller: "spree/admin/banners", action: 'new')
    end

    it "routes to #create" do
      expect(post "/admin/banners").to route_to(controller: "spree/admin/banners", action: 'create')
    end

    it "routes to #edit" do
      expect(get "/admin/banners/1/edit").to route_to(controller: "spree/admin/banners", action: 'edit', id: '1')
    end

    it "routes to #update" do
      expect(put "/admin/banners/1").to route_to(controller: "spree/admin/banners", action: 'update', id: '1')
    end

    it "routes to #destroy" do
      expect(delete "/admin/banners/1").to route_to(controller: "spree/admin/banners", action: 'destroy', id: '1')
    end
  end
end
