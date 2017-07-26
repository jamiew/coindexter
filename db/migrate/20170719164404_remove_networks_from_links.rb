class RemoveNetworksFromLinks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :links, :networks
  end
end
