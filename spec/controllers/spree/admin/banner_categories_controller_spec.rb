require 'spec_helper'

RSpec.describe Spree::Admin::BannerCategoriesController, :type => :controller do

  let(:banner_category) { FactoryGirl.create(:banner_category) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:banner_category) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_banner_category) }

  before(:each) do
      @user = FactoryGirl.create(:admin_user)
      sign_in @user
  end

  describe "GET index" do
    before(:each) { spree_get :index }
    it { expect(response).to be_success }
    it { expect(response).to render_template("index") }

    it "assigns all banner_categories as @banner_categories" do
      expect(assigns(:banner_categories)).to eq([banner_category])
    end
  end

  describe "GET new" do
    before(:each) { spree_get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template("new") }

    it "assigns a new banner_category as @banner_category" do
      expect(assigns(:banner_category)).to be_a_new(Spree::BannerCategory)
    end
  end

  describe "GET edit" do
    before(:each) { spree_get :edit, id: banner_category.to_param }

    it { expect(response).to be_success }
    it { expect(response).to render_template("edit") }

    it "assigns the requested banner_category as @banner_category" do
      expect(assigns(:banner_category)).to eq(banner_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new banner_category" do
        expect {
          spree_post :create, banner_category: valid_attributes
        }.to change(Spree::BannerCategory, :count).by(1)
      end

      context 'automatic request' do
        before(:each) { spree_post :create, banner_category: valid_attributes }

        it { expect(response.status).to eq(302) }

        it { expect(assigns(:banner_category)).to be_a(Spree::BannerCategory) }
        it { expect(assigns(:banner_category)).to be_persisted }

        it { expect(response).to redirect_to(spree.admin_banner_categories_path) }

        it "has no error messages" do
          expect(flash[:error]).to be_nil
        end
        it "has a success message" do
          expect(flash[:success]).to_not be_nil
        end
      end
    end

    describe "with invalid params" do
      before(:each) { spree_post :create, banner_category: invalid_attributes }

      it "assigns a newly created but unsaved banner_category as @banner_category" do
        expect(assigns(:banner_category)).to be_a_new(Spree::BannerCategory)
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
      before(:each) { spree_put :update, id: banner_category.to_param, banner_category: valid_attributes.merge(name: 'Another Name') }

      it "updates the requested banner_category" do
        banner_category.reload
        expect(banner_category.name).to eq('Another Name')
      end

      it { expect(response.status).to eq(302) }

      it "assigns the requested banner_category as @banner_category" do
        expect(assigns(:banner_category)).to eq(banner_category)
      end

      it { expect(response).to redirect_to(spree.admin_banner_categories_path) }

      it "has no error messages" do
        expect(flash[:error]).to be_nil
      end
      it "has a success message" do
        expect(flash[:success]).to_not be_nil
      end
    end

    describe "with invalid params" do
      before(:each) { spree_put :update, id: banner_category.to_param, banner_category: invalid_attributes }

      it "assigns the banner_category as @banner_category" do
        expect(assigns(:banner_category)).to eq(banner_category)
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
    it "delete requested banner_category" do
      banner_category.reload
      expect {
        spree_delete :destroy, id: banner_category.to_param
      }.to change(Spree::BannerCategory, :count).by(-1)
    end

    context 'automatic request' do
      before(:each) { spree_delete :destroy, id: banner_category.to_param }

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to(spree.admin_banner_categories_path) }

      it "has no error messages" do
        expect(flash[:error]).to be_nil
      end
      it "has a success message" do
        expect(flash[:success]).to_not be_nil
      end
    end
  end
end