module Spree
  class BannerCategory < ActiveRecord::Base
    has_many :banners

    validates :name, presence: true
    validates :size, presence: true


    # http://www.imagemagick.org/script/command-line-processing.php#geometry
    VALID_FORMATS = [
                      '\d+%',       # scale%            # Height and width both scaled by specified percentage.
                      '\d+%x\d+%',  # scale-x%xscale-y% # Height and width individually scaled by specified percentages. (Only one % symbol needed.)
                      '\d+',        # width             # Width given, height automagically selected to preserve aspect ratio.
                      'x\d+',       # xheight           # Height given, width automagically selected to preserve aspect ratio.
                      '\d+x\d+',    # widthxheight      # Maximum values of height and width given, aspect ratio preserved.
                      '\d+x\d+\^',  # widthxheight^     # Minimum values of width and height given, aspect ratio preserved.
                      '\d+x\d+!',   # widthxheight!     # Width and height emphatically given, original aspect ratio ignored.
                      '\d+x\d+>',   # widthxheight>     # Shrinks an image with dimension(s) larger than the corresponding width and/or height argument(s).
                      '\d+x\d+<',   # widthxheight<     # Enlarges an image with dimension(s) smaller than the corresponding width and/or height argument(s).
                      '\d+@'        # area@             # Resize image to have specified area in pixels. Aspect ratio is preserved.
                                    # {size}{offset}    # Specifying the offset (default is +0+0). Below, {size} refers to any of the forms above.
                                    # {size}{+-}x{+-}y  # Horizontal and vertical offsets x and y, specified in pixels. Signs are required for both. Offsets are affected by ‑gravity setting. Offsets are not affected by % or other size operators.
                    ]

    validates :size, format: { with: Regexp.new("^(#{VALID_FORMATS.join('|')})$"), :multiline => true }

    before_update :update_banners_geometry

    def update_banners_geometry
      self.banners.each do |banner|
        BannerGeometryJob.perform_later(banner)
      end
    end
  end
end
