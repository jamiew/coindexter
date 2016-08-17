class ChangeWhitepapersInNetworks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :networks, :whitepaper_title
  	remove_column :networks, :whitepaper_url
  	add_column :networks, :whitepapers, :jsonb, null:false, default: {}
  end
end
