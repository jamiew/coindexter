class ChangeCapitalRaisedInCoins < ActiveRecord::Migration[5.0]
  def change
  	remove_column :coins, :capital_raised
  	add_column :coins, :capital_raised, :integer
  end
end
