class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :link
      t.string :title
      t.integer :coin_id
      t.integer :category_id

      t.timestamps
    end
  end
end
