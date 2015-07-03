class BannerGeometryJob < ActiveJob::Base
  queue_as :default

  def perform(banner)
    banner.image.reprocess! if banner.image? and banner.banner_category
  end
end
