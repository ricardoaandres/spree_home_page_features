module Spree
  module Admin
    class HomePageFeaturesController < ResourceController
      before_action :load_data, except: [:index]

      protected

      def load_data
        @taxons = Spree::Taxon.order(:name)
        @products = Spree::Product.active.order(:name)
      end

      def collection
        return @collection if @collection.present?

        @collection = super
        @collection = @collection.page(params[:page]).
                                  per(params[:per_page] || Spree::Config[:admin_products_per_page])

        @collection
      end
    end
  end
end
