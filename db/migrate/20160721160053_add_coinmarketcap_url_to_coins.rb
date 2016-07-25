class AddCoinmarketcapUrlToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :coinmarketcap_url, :string
  end
end
