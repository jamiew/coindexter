class AddCoinMarketCapIdToCoins < ActiveRecord::Migration[5.0]
  def change
  	add_column :coins, :coin_market_cap_id, :integer
  end
end
