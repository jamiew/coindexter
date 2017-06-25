class ChangeCoinsColumns < ActiveRecord::Migration[5.0]
  def change
  	rename_column :coins, :use_of_proceeds, :ico_use_of_proceeds
  	add_column :coins, :ico_token_sale_structure, :text
  end
end
