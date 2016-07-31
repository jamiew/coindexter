class ChangeCoinNameInCoins < ActiveRecord::Migration[5.0]
  def change
  	add_index :coins, :name, unique: true
  end
end
