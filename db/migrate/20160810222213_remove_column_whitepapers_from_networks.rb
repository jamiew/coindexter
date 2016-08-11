class RemoveColumnWhitepapersFromNetworks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :networks, :whitepapers
  	add_column :networks, :whitepaper_title, :string
  	add_column :networks, :whitepaper_url, :string
  end
end
