require 'spec_helper'

describe Spree::BannerCategory, type: :model do

  ###############
  # attributes #
  ##############
  it { expect(subject).to respond_to :name }
  it { expect(subject).to respond_to :size }

  ################
  # associations #
  ################
  it { expect(subject).to have_many :banners }

  ###############
  # validations #
  ###############
  it 'has a valid factory' do
    expect(FactoryGirl.build(:banner_category)).to be_valid
  end

  it 'has an invalid factory' do
    expect(FactoryGirl.build(:invalid_banner_category)).not_to be_valid
  end

  context "when having different size values" do

    it "is valid if it only specifies width" do
      expect(FactoryGirl.build(:banner_category, size: '10')).to be_valid
    end

    it "is valid if it only specifies height" do
      expect(FactoryGirl.build(:banner_category, size: 'x10')).to be_valid
    end

    it "is valid if it specifies percentage scale" do
      expect(FactoryGirl.build(:banner_category, size: '50%')).to be_valid
    end

    it "is valid if it specifies a shrinking of images larger than width/height" do
      expect(FactoryGirl.build(:banner_category, size: '10x10>')).to be_valid
    end    

    it "is not valid if it ends with a question mark" do
      expect(FactoryGirl.build(:banner_category, size: '10x21?')).not_to be_valid
      expect(FactoryGirl.build(:banner_category, size: 'hello')).not_to be_valid
    end
  end  
end
