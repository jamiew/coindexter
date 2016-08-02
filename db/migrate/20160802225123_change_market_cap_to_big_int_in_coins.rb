class ChangeMarketCapToBigIntInCoins < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :available_supply, :integer, :limit => 6
  end
end
