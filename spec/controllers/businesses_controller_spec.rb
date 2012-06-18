require 'spec_helper'

describe BusinessesController do
  render_views

  [:show, :edit].each do |action|
    context action do
      it "should 404 on int id does not exist" do
        get action, :id => 999
        response.status.should be(404)
      end

      it "should 404 on string id does not exist" do
        get action, :id => "rar"
        response.status.should be(404)
      end

      it "should get requested business" do
        business = FactoryGirl.create(:business)
        get action, {:id => business.to_param}
        response.should be_success
      end
    end
  end
end
