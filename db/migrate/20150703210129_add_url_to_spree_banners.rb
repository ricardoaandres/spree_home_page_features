class AddUrlToSpreeBanners < ActiveRecord::Migration
  def change
    add_column :spree_banners, :url, :string
  end
end
