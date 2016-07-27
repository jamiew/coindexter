class ChangeOneDayPriceChangeToDecimal < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :one_day_price_change, :decimal
  end
end
