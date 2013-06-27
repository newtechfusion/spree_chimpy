class Spree::Chimpy::SubscribersController < ApplicationController
  respond_to :html

  def create
    @subscriber = Spree::Chimpy::Subscriber.where(email: params[:chimpy_subscriber][:email]).first_or_initialize
    @subscriber.update_attributes(params[:chimpy_subscriber])
    if @subscriber.save
      Spree::Chimpy::Subscription.new(@subscriber).subscribe
      flash[:notice] = Spree.t('chimpy.subscriber.success')
    else
      flash[:error] = Spree.t('chimpy.subscriber.failure')
    end

    respond_with @subscriber, location: request.referer
  end
end
