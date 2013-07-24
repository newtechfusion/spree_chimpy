require 'spec_helper'

describe Spree::Chimpy::SubscribersController do
  let(:spree_chimpy_subscriber) { create(:subscriber) }
  let(:valid_attributes) { attributes_for(:subscriber) }

#post method for create the new subsciber with valid attributes
context "POST create" do
  it "creates a new subscriber" do 
   expect{

   post :create, subscriber: Factory.attributes_for(:subscriber)
   response.should be_success
    }

end 
  end

#post method for create not to save the subscriber with invalid attributes
context "with invalid attributes"do 
 it "does not save the new subscriber" do 
 	expect{
  	 post :create, subscriber: Factory.attributes_for(:invalid_subscriber)

  	 flash[:error] = Spree.t('chimpy.subscriber.failure')
 
  	}
  	end 
 end 
end