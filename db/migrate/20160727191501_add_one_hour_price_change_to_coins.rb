class AddOneHourPriceChangeToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :one_hour_price_change, :decimal
  end
end
