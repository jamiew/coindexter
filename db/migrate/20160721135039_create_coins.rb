class CreateCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.text :info_way_to_earn
      t.string :info_status
      t.text :info_additional
      t.integer :price
      t.integer :thirty_day_price_change
      t.integer :one_day_price_change
      t.integer :volume
      t.integer :market_cap
      t.string :application_name
      t.text :application_description
      t.string :application_status
      t.string :application_category
      t.string :logo_url

      t.timestamps
    end
  end
end
