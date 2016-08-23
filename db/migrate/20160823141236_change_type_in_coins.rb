class ChangeTypeInCoins < ActiveRecord::Migration[5.0]
  def change
  	rename_column :coins, :type, :coin_type
  end
end
