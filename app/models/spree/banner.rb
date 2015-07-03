module Spree
  class Banner < ActiveRecord::Base
    include GlobalID::Identification
    include Spree::Core::Engine.routes.url_helpers

    validates :title, presence: true, length: { minimum: 1 }
    validates :body,  presence: true, length: { minimum: 1 }, unless: :image

    validates :url, format: URI::regexp(%w(http https)), unless: Proc.new { |b| b.url.blank? }
    validates :url, presence: true, if: Proc.new { |b| b.product_id.blank? and b.taxon_id.blank? }

    has_attached_file :image,
                      :url => '/spree/banners/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/banners/:id/:style/:basename.:extension',
                      :styles => Proc.new { |attachment| attachment.instance.image_styles }

    validates_attachment_presence :image, unless: :body

    validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/

    scope :published, -> { where publish: true }

    scope :by_category_name, -> (banner_category) { joins(:banner_category).where(spree_banner_categories: {name: banner_category}) }
    scope :by_category,      -> (banner_category) { where(spree_banners: {banner_category_id: banner_category}) }

    belongs_to :product
    belongs_to :taxon
    belongs_to :banner_category

    delegate :name, to: :banner_category, prefix: true, allow_nil: true

    before_update :update_geometry

    def update_geometry
      BannerGeometryJob.perform_later(self) unless image_updated_at_changed?
    end

    def image_styles
      if banner_category
        { original: banner_category.size }
      else
        {}
      end
    end

    def publish_icon
      self.publish ? "<i class='icon icon-ok'></i>".html_safe : '<br/>'.html_safe
    end

    def display_url
      if url.present?
        return url
      else
        if taxon && product
          product_path(product, taxon_id: taxon.id)
        elsif product
          product_path(product)
        elsif taxon
          nested_taxons_path(taxon.permalink)
        end
      end
    end

    class << self
      def styles
        @styles ||= []
      end

      def styles=(styles)
        @styles = styles
      end

      def styles_dropdown
        styles.map { |s| [ s.humanize, s ] }
      end
    end

    def display_texts?
      display_body? || display_title?
    end

    def allowed_attributes
      [
       :title, :body, :publish, :style, :image, :product_id, :taxon_id,
       :image_file_name, :image_file_size, :image_content_type, :image_updated_at,
       :display_title, :display_body, :banner_category_id, :url
      ]
    end
  end
end
