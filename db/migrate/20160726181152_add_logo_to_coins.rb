class AddLogoToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :logo, :string
  end
end
