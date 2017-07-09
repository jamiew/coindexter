class ChargesController < ApplicationController

	def new
		@user = User.friendly.find(params[:user_id])
		@active_item = 'subscription'
	end

	def create
	  # Amount in cents
	  @amount = 500

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :source  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	  rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end

	def update 

		Stripe.api_key = ENV['STRIPE_PUBLISHABLE_KEY']

		# Token is created using Stripe.js or Checkout!
		# Get the payment token submitted by the form:
		token = params[:stripeToken]

		# Charge the user's card:
		charge = Stripe::Charge.create(
		  :amount => 1000,
		  :currency => "usd",
		  :description => "Example charge",
		  :source => token,
		)
	end

end
