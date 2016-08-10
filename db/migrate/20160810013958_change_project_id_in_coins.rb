class ChangeProjectIdInCoins < ActiveRecord::Migration[5.0]
  def change
  	rename_column :coins, :project_id, :network_id
  end
end
