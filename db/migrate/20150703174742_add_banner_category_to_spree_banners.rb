class AddBannerCategoryToSpreeBanners < ActiveRecord::Migration
  def change
    add_reference :spree_banners, :banner_category, index: true
    add_foreign_key :spree_banners, :spree_banner_categories, column: :banner_category_id
  end
end
