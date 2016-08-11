class ChangeWhitepaperToArrayInNetworks4 < ActiveRecord::Migration[5.0]
  def change
  	change_column :networks, :whitepapers, :text, array: true, default: []
  end
end
