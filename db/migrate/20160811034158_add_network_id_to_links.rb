class AddNetworkIdToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :network_id, :integer, array: true, default: []
  end
end
