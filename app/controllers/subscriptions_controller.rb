class SubscriptionsController < ApplicationController
	require "stripe"

	def new
		@user = User.friendly.find(params[:user_id])
		@active_item = 'subscription'
		@stripe_list = Stripe::Plan.all
  		@plan = @stripe_list[:data].first
	end

	def create
	  @user = User.friendly.find(params[:username])

	  plan_id = 'standard-plan'
	  plan = Stripe::Plan.retrieve(plan_id)

	  customer = Stripe::Customer.create(
	          :description => "Customer for test plan",
	          :source => params[:stripeToken],
	          :email => @user.email
	        )

	  stripe_subscription = customer.subscriptions.create(:plan => plan.id)

	  @user.update_attributes(stripe_customer_id: customer.id)

  	  flash[:notice] = "Successfully created a charge"

	  rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_user_path

	end

	def update 

	end

	def subscription_checkout 

	end

	def webhook
	  begin
	    event_json = JSON.parse(request.body.read)
	    event_object = event_json['data']['object']
	    #refer event types here https://stripe.com/docs/api#event_types
	    case event_json['type']
	      when 'invoice.payment_succeeded'
	        handle_success_invoice event_object
	      when 'invoice.payment_failed'
	        handle_failure_invoice event_object
	      when 'charge.failed'
	        handle_failure_charge event_object
	      when 'customer.subscription.deleted'
	      when 'customer.subscription.updated'
	    end
	  rescue Exception => ex
	    render :json => {:status => 422, :error => "Webhook call failed"}
	    return
	  end
	  render :json => {:status => 200}
	end

end
