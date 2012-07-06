require 'spec_helper'

describe "Products" do
  before do
    @business = FactoryGirl.create(:business)
    @catalog = FactoryGirl.create(:catalog, :business=>@business)
  end
end
