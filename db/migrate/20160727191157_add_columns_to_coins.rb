class AddColumnsToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :available_supply, :integer
    add_column :coins, :total_supply, :integer
    remove_column :coins, :thirty_day_price_change
  end
end
