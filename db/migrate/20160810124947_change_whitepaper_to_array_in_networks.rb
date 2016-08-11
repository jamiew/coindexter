class ChangeWhitepaperToArrayInNetworks < ActiveRecord::Migration[5.0]
  def change
  	rename_column :networks, :whitepaper_title, :whitepaper 
  	change_column :networks, :whitepaper, "varchar[] USING (string_to_array(whitepaper, ','))"
  	remove_column :networks, :whitepaper_url
  end
end
