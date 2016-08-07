class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :link
      t.string :status
      t.string :team
      t.string :founders
      t.string :slack
      t.string :forum
      t.integer :coin_id

      t.timestamps
    end
  end
end
