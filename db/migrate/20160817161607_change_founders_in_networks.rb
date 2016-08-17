class ChangeFoundersInNetworks < ActiveRecord::Migration[5.0]
  def change
  	change_column :networks, :founders, :string, array: true, default: '{}'
  end
end
