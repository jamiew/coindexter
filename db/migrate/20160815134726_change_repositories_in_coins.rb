class ChangeRepositoriesInCoins < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :repositories, :jsonb, null:false, default: {}
  end
end
