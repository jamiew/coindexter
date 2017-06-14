class MonetaryPolicyToCoins < ActiveRecord::Migration[5.0]
  def change
  	add_column :coins, :monetary_poicy, :text
  end
end
