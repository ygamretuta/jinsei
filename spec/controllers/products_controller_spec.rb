require 'spec_helper'

describe ProductsController do

  render_views

  describe "GET 'index'" do
    before do
      @business = FactoryGirl.create(:business)
      @catalog = FactoryGirl.create(:catalog, :business=>@business)
      @product1 = FactoryGirl.create(:product, :business=>@business)
      @product2 = FactoryGirl.create(:product, :business=>@business, :catalog=>@catalog)
    end

    it "should show product with catalog if catalog is given" do
      Catalog.any_instance.should_receive(:products).and_return([@product2])
      get :index, :business_id=>@business.slug, :catalog_id=>@catalog.slug
    end

    it "should show all products in business if no catalog is given" do
      Business.any_instance.should_receive(:products).and_return([@product1])
      get :index, :business_id=>@business.slug
    end
  end
end