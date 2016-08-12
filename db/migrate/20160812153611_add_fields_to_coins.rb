class AddFieldsToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :repositories, :jsonb, null:false, default: '{}'
    add_column :coins, :code_license, :string
    add_column :coins, :technology, :string
    add_column :coins, :proof_algorithm, :string
    add_column :coins, :type, :string
  end
end
