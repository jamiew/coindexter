class RenameProjectsTableName < ActiveRecord::Migration[5.0]
  def change
  	rename_table :projects, :networks
  end
end
