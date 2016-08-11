class RemoveCoinsAndNetworkIdFromLinks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :links, :coins
  	remove_column :links, :network_id
  end
end
