require 'spec_helper' 

describe Spree::Chimpy::OrderSource do

    it "should have a order" do
      order_source = FactoryGirl.create(:order_source)
      order_source.order.should_not be_nil
    end

    it "should have a compaign" do
      order_source = FactoryGirl.create(:order_source)
      order_source.campaign_id.should_not be_nil
    end

    it "should have a email" do
      order_source = FactoryGirl.create(:order_source)
      order_source.email_id.should_not be_nil
    end
   

end