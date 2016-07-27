class ChangePriceTypeInCoins < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :price, :decimal
  end
end
