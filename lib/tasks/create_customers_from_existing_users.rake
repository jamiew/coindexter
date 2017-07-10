task :create_customers_from_existing_users => :environment do

	Stripe.api_key = ENV['STRIPE_SECRET_KEY']

	User.all.each do |user|
		customer = Stripe::Customer.create(
		  :email => user.email
		)
		user.stripe_customer_id = customer["id"]
	end

end