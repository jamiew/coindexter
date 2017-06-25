class AddFieldsToNetworks < ActiveRecord::Migration[5.0]
  def change
  	add_column :networks, :team_location, :string
  	add_column :networks, :blockchain, :string
  	add_column :coins, :capital_raised, :integer
  	add_column :coins, :ico_use_of_proceeds, :text
  	add_column :coins, :ico_token_sale_structure, :text
    add_column :coins, :ico_pricing, :string
  	add_column :coins, :ico_amount_sold, :string
  	add_column :coins, :ico_allocation, :text
  	add_column :coins, :ico_lockup, :text
  	add_column :coins, :ico_buyer_lockup, :text
  	add_column :coins, :ico_founder_lockup, :text
  	add_column :coins, :ico_min_investment_cap, :string
  	add_column :coins, :ico_type_of_min_cap, :string
  	add_column :coins, :ico_max_investment_cap, :string
  	add_column :coins, :ico_currency_accepted, :string
  	add_column :coins, :ico_additional_notes, :text
  	add_column :coins, :ico_planned_end_date, :datetime
  	add_column :coins, :ico_actual_end_date, :datetime
  end
end
