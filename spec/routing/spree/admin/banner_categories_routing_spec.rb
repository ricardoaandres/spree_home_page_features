require "spec_helper"

describe Spree::Admin::BannerCategoriesController, :type => :routing do
  describe "routing" do
    routes { Spree::Core::Engine.routes }

    it "routes to #index" do
      expect(get "/admin/banner_categories").to route_to(controller: "spree/admin/banner_categories", action: 'index')
    end

    it "routes to #new" do
      expect(get "/admin/banner_categories/new").to route_to(controller: "spree/admin/banner_categories", action: 'new')
    end

    it "routes to #create" do
      expect(post "/admin/banner_categories").to route_to(controller: "spree/admin/banner_categories", action: 'create')
    end

    it "routes to #edit" do
      expect(get "/admin/banner_categories/1/edit").to route_to(controller: "spree/admin/banner_categories", action: 'edit', id: '1')
    end

    it "routes to #update" do
      expect(put "/admin/banner_categories/1").to route_to(controller: "spree/admin/banner_categories", action: 'update', id: '1')
    end

    it "routes to #destroy" do
      expect(delete "/admin/banner_categories/1").to route_to(controller: "spree/admin/banner_categories", action: 'destroy', id: '1')
    end
  end
end
