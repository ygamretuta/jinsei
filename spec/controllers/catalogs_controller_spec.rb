require 'spec_helper'

describe CatalogsController do

  render_views

  describe "GET 'index'" do
    before do
      @business = FactoryGirl.create(:business)
    end

    def do_get
      get :index, :business_id => @business
    end

    it "should find business" do
      Business.should_receive(:find).with(@business.slug.to_s).and_return(@business)
      do_get
    end
  end

  describe "GET 'show'" do
    before do
      @business = FactoryGirl.create(:business)
      @catalog = FactoryGirl.create(:catalog, :business=>@business)
      @product1 = FactoryGirl.create(:product, :business=>@business, :catalog=>@catalog)
      @product2 = FactoryGirl.create(:product, :business=>@business, :catalog=>@catalog)
    end

    def do_show
      get :show, :business_id=>@business.slug, :id=>@catalog.slug
    end

    it "should show products" do
      Catalog.any_instance.should_receive(:products).and_return([@product1, @product2])
      do_show
    end
  end
end