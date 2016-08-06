class AddUserIdToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :user_id, :integer
  end
end
