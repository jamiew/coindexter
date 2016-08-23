class AddExchangesToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :exchanges, :jsonb, null:false, default: {}
  end
end
