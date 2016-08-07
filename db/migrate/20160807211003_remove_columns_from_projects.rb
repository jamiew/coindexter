class RemoveColumnsFromProjects < ActiveRecord::Migration[5.0]
  def change
  	remove_columns :projects, :user_id, :category_id, :coin_id
  	add_reference :projects, :user, index: true
  	add_reference :projects, :category, index: true
  	add_reference :projects, :coin, index: true
  end
end
