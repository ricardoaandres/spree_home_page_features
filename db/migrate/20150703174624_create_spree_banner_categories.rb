class CreateSpreeBannerCategories < ActiveRecord::Migration
  def change
    create_table :spree_banner_categories do |t|
      t.string :name
      t.string :size

      t.timestamps null: false
    end
  end
end
