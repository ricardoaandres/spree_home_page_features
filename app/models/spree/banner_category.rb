class Spree::BannerCategory < ActiveRecord::Base
  has_many :banners

  validates :name,  presence: true
  validates :style, presence: true
end
