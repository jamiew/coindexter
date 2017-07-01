class AddCoinmarketcapIdToCoin < ActiveRecord::Migration[5.0]
  def change
  	add_column :coin, :coin_market_cap_id, :integer
  end
end
