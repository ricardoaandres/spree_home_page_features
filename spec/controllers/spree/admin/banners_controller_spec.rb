require 'spec_helper'

RSpec.describe Spree::Admin::BannersController, :type => :controller do

  let(:banner) { FactoryGirl.create(:banner, :with_product_and_taxon) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:banner, :with_product_and_taxon, product_id: banner.product.id, taxon_id: banner.taxon.id) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_banner) }

  before(:each) do
      @user = FactoryGirl.create(:admin_user)
      sign_in @user
  end

  describe "GET index" do
    before(:each) { spree_get :index }
    it { expect(response).to be_success }
    it { expect(response).to render_template("index") }

    it "assigns all banners as @banners" do
      expect(assigns(:banners)).to eq([banner])
    end
  end

  describe "GET new" do
    before(:each) { spree_get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template("new") }

    it "assigns a new banner as @banner" do
      expect(assigns(:banner)).to be_a_new(Spree::Banner)
    end
    it "assigns active products as @products" do
      expect(assigns(:products)).to eq([banner.product])
    end
  end

  describe "GET edit" do
    before(:each) { spree_get :edit, id: banner.to_param }

    it { expect(response).to be_success }
    it { expect(response).to render_template("edit") }

    it "assigns the requested banner as @banner" do
      expect(assigns(:banner)).to eq(banner)
    end
    it "assigns active products as @products" do
      expect(assigns(:products)).to eq([banner.product])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new banner" do
        banner.reload
        expect {
          spree_post :create, banner: valid_attributes
        }.to change(Spree::Banner, :count).by(1)
      end

      context 'automatic request' do
        before(:each) { spree_post :create, banner: valid_attributes }

        it { expect(response.status).to eq(302) }

        it { expect(assigns(:banner)).to be_a(Spree::Banner) }
        it { expect(assigns(:banner)).to be_persisted }

        it { expect(response).to redirect_to(spree.admin_banners_path) }

        it "has no error messages" do
          expect(flash[:error]).to be_nil
        end
        it "has a success message" do
          expect(flash[:success]).to_not be_nil
        end
      end
    end

    describe "with invalid params" do
      before(:each) { spree_post :create, banner: invalid_attributes }

      it "assigns a newly created but unsaved banner as @banner" do
        expect(assigns(:banner)).to be_a_new(Spree::Banner)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
      it "has an error message" do
        expect(flash[:error]).to_not be_nil
      end
      it "has no success messages" do
        expect(flash[:success]).to be_nil
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before(:each) { spree_put :update, id: banner.to_param, banner: valid_attributes.merge(title: 'Another Title') }

      it "updates the requested banner" do
        banner.reload
        expect(banner.title).to eq('Another Title')
      end

      it { expect(response.status).to eq(302) }

      it "assigns the requested banner as @banner" do
        expect(assigns(:banner)).to eq(banner)
      end

      it { expect(response).to redirect_to(spree.admin_banners_path) }

      it "has no error messages" do
        expect(flash[:error]).to be_nil
      end
      it "has a success message" do
        expect(flash[:success]).to_not be_nil
      end
    end

    describe "with invalid params" do
      before(:each) { spree_put :update, id: banner.to_param, banner: invalid_attributes }

      it "assigns the banner as @banner" do
        expect(assigns(:banner)).to eq(banner)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end

      it "has an error message" do
        expect(flash[:error]).to_not be_nil
      end
      it "has no success messages" do
        expect(flash[:success]).to be_nil
      end
    end
  end

  describe "DELETE destroy" do
    it "delete requested banner" do
      banner.reload
      expect {
        spree_delete :destroy, id: banner.to_param
      }.to change(Spree::Banner, :count).by(-1)
    end

    context 'automatic request' do
      before(:each) { spree_delete :destroy, id: banner.to_param }

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to(spree.admin_banners_path) }

      it "has no error messages" do
        expect(flash[:error]).to be_nil
      end
      it "has a success message" do
        expect(flash[:success]).to_not be_nil
      end
    end
  end
end