class AlterMonetaryPolicyToCoins < ActiveRecord::Migration[5.0]
  def change
  	rename_column :coins, :monetary_poicy, :monetary_policy
  end
end
