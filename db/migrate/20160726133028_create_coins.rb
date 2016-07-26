class CreateCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.text :coin_info
      t.string :coin_status
      t.integer :price
      t.integer :thirty_day_price_change
      t.integer :one_day_price_change
      t.integer :volume
      t.integer :market_cap
      t.string :application_name
      t.text :application_description
      t.string :application_status
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
