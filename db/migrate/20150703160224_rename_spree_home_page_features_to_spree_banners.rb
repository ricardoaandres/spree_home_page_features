class RenameSpreeHomePageFeaturesToSpreeBanners < ActiveRecord::Migration
  def change
    rename_table :spree_home_page_features, :spree_banners
  end
end
