module Spree
  class Banner < ActiveRecord::Base
    include GlobalID::Identification

    validates :title, presence: true, length: { minimum: 1 }
    validates :body,  presence: true, length: { minimum: 1 }, unless: :image

    has_attached_file :image,
                      :url => '/spree/banners/:id/:style/:basename.:extension',
                      :path => ':rails_root/public/spree/banners/:id/:style/:basename.:extension'

    validates_attachment_presence :image, unless: :body

    validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/

    scope :published, -> { where publish: true }

    belongs_to :product
    belongs_to :taxon
    belongs_to :banner_category

    delegate :name, to: :banner_category, prefix: true, allow_nil: true

    def publish_icon
      self.publish ? "<i class='icon icon-ok'></i>".html_safe : '<br/>'.html_safe
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
       :display_title, :display_body, :banner_category_id
      ]
    end
  end
end
