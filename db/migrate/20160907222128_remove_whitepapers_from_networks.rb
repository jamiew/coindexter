class RemoveWhitepapersFromNetworks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :networks, :whitepapers
  end
end
