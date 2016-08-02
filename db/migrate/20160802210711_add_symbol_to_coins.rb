class AddSymbolToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :symbol, :string
  end
end
