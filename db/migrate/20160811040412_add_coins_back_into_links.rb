class AddCoinsBackIntoLinks < ActiveRecord::Migration[5.0]
  def change
  	add_column :links, :coins, :integer, array: true, default: []
  end
end
