class CreateLinks2 < ActiveRecord::Migration[5.1]
  def change
  	drop_join_table :networks, :links
    create_table :links do |t|
      t.string :link
      t.references :network, foreign_key: true
      t.text :body
      t.string :title
    end
  end
end
