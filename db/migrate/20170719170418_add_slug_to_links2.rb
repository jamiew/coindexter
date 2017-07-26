class AddSlugToLinks2 < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :slug, :string
  end
end
