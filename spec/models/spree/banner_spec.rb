require 'spec_helper'

describe Spree::Banner, type: :model do

  ###############
  # attributes #
  ##############
  it { expect(subject).to respond_to :title }
  it { expect(subject).to respond_to :display_title }
  it { expect(subject).to respond_to :body }
  it { expect(subject).to respond_to :display_body }
  it { expect(subject).to respond_to :url }
  it { expect(subject).to respond_to :style }
  it { expect(subject).to respond_to :publish }
  it { expect(subject).to respond_to :image }
  it { expect(subject).to respond_to :image_file_name }
  it { expect(subject).to respond_to :image_content_type }
  it { expect(subject).to respond_to :image_file_size }
  it { expect(subject).to respond_to :image_updated_at }

  ################
  # associations #
  ################
  it { expect(subject).to belong_to :product }
  it { expect(subject).to belong_to :taxon }
  it { expect(subject).to belong_to :banner_category }

  ###############
  # validations #
  ###############
  it 'has a valid factory' do
    expect(FactoryGirl.build(:banner)).to be_valid
  end

  it 'has an invalid factory' do
    expect(FactoryGirl.build(:invalid_banner)).not_to be_valid
  end

  context "without body" do
    context "when image is blank" do
      before(:each) { @banner = FactoryGirl.build(:banner, body: '') }

      it "is not valid" do
        expect(@banner).not_to be_valid
      end

      it "validates image attachment" do
        expect(@banner).to validate_attachment_presence(:image)
      end
    end

    context "when image is present" do
      before(:each) { @banner = FactoryGirl.build(:banner, :with_image) }

      it "is valid" do
        expect(@banner).to be_valid
      end

      it "validates image attachment" do
        expect(@banner).to validate_attachment_presence(:image)
        expect(@banner).to validate_attachment_content_type(:image).allowing('image/jpg')
      end
    end
  end

  context "without url" do
    it "is not valid if product and taxon are blank" do
      expect(FactoryGirl.build(:banner, url: nil)).not_to be_valid
    end

    it "is valid if product or taxon are present" do
      expect(FactoryGirl.create(:banner, :with_product_and_taxon)).to be_valid
    end
  end

  ###########
  # methods #
  ###########
  describe "#display_url" do
    context "when having URL field defined" do
      it "returns that URL" do
        banner = FactoryGirl.create(:banner)
        expect(banner.display_url).to eq(banner.url)
      end
    end

    context "when having product and taxon" do
      it "returns the product URL with taxon scoped" do
        banner = FactoryGirl.create(:banner, :with_product_and_taxon)
        expect(banner.display_url).to eq(spree.product_path(banner.product, taxon_id: banner.taxon.id))
      end
    end

    context "when having only product" do
      it "returns the product URL" do
        banner = FactoryGirl.create(:banner, :with_product_and_taxon, taxon: nil)
        expect(banner.display_url).to eq(spree.product_path(banner.product))
      end
    end

    context "when having only taxon" do
      it "returns the taxon URL" do
        banner = FactoryGirl.create(:banner, :with_product_and_taxon, product: nil)
        expect(banner.display_url).to eq(spree.nested_taxons_path(banner.taxon.permalink))
      end
    end
  end
end
