class ChangeSlugInLinks < ActiveRecord::Migration[5.0]
  def change
 	add_index :links, :slug, unique: true
  end
end
