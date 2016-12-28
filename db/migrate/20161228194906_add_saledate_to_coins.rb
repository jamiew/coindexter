class AddSaledateToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :saledate, :datetime
  end
end
