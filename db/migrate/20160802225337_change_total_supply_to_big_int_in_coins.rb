class ChangeTotalSupplyToBigIntInCoins < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :total_supply, :integer, :limit => 6
  end
end
