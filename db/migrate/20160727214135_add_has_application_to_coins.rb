class AddHasApplicationToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :has_application, :boolean
  end
end
