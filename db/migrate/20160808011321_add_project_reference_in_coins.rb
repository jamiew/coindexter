class AddProjectReferenceInCoins < ActiveRecord::Migration[5.0]
  def change
  	remove_column :coins, :user_id
  	add_reference :coins, :user, index: true
  	add_reference :coins, :project, index: true
  	add_reference :coins, :links, index: true
  end
end
