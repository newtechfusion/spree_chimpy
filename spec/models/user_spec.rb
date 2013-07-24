require 'spec_helper'

describe Spree::User do
  context "syncing with mail chimp" do
    let(:subscription) { double(:subscription, needs_update?: true) }

    before do
      subscription.should_receive(:subscribe)
      Spree::Chimpy::Subscription.should_receive(:new).at_least(1).and_return(subscription)
      @user = create(:user)
    end

    it "submits after saving" do
      subscription.should_receive(:resubscribe)

      @user.save
    end

    it "submits after destroy" do
      subscription.should_receive(:unsubscribe)

      @user.destroy
    end
    
    #to generate the api key in the chimpy mail to mailing
    it "can generate an API key" do
      @user.should_receive(:save!)
      @user.generate_spree_api_key!
      @user.spree_api_key.should_not be_blank

    end

    #after closing to clear the api key 
    it "can clear an API key" do
       @user.should_receive(:save!)
       @user.clear_spree_api_key!
       @user.spree_api_key.should be_blank
    end

  end

  context "defaults" do
    it "subscribed by default" do
      Spree::Chimpy::Config.subscribed_by_default = true
      Spree.user_class.new.subscribed.should be_true
    end

    it "doesnt subscribe by default" do
      Spree::Chimpy::Config.subscribed_by_default = false
      Spree.user_class.new.subscribed.should be_false
    end
  end
end
