class ChangeWhitepaperToArrayInNetworks3 < ActiveRecord::Migration[5.0]
  def change
  	rename_column :networks, :whitepaper, :whitepapers
  	change_column :networks, :whitepapers, :string, array: true, default: []
  	Network.reset_column_information
  end
end
