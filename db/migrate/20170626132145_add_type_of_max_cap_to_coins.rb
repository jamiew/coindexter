class AddTypeOfMaxCapToCoins < ActiveRecord::Migration[5.0]
  def change
  	add_column :coins, :ico_type_of_max_cap, :string
  end
end
