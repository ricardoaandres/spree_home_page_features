class AddBannerCategoryToSpreeBanners < ActiveRecord::Migration
  def change
    add_reference :spree_banners, :banner_category, index: true, foreign_key: true
  end
end
