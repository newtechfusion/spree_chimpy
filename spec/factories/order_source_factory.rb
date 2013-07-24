FactoryGirl.define do
  factory :order_source, class: Spree::Chimpy::OrderSource do
	    
#association with order and setting the values to dynamic
	association :order
	campaign_id '' 
	email_id ''
  
  end
end
