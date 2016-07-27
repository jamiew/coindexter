class ChangePriceToBigIntInCoins < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :market_cap, :integer, :limit => 6
  end
end
