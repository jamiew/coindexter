class ChangeNetworksAndCoinsInLinks < ActiveRecord::Migration[5.0]
  def change
  	rename_column :links, :coin_id, :coins
  	change_column :links, :coins, 'integer USING CAST(coins AS integer)'
  	add_column :links, :networks, :integer, array: true, default: []
  end
end
