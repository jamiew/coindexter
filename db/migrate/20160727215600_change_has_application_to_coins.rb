class ChangeHasApplicationToCoins < ActiveRecord::Migration[5.0]
  def change
  	change_column :coins, :has_application, :boolean, :default => true
  end
end
