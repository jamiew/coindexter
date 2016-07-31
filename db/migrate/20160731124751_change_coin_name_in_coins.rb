class ChangeCoinNameInCoins < ActiveRecord::Migration[5.0]
  def change
  	add_index :coins, :name
  	change_column :coins, :name, :unique
  end
end
