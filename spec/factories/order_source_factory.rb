FactoryGirl.define do
  factory :order_source, class: Spree::Chimpy::OrderSource do
    order
    # ? campaign_id, :email_id
  end
end
