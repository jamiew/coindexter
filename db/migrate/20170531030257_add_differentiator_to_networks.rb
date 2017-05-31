class AddDifferentiatorToNetworks < ActiveRecord::Migration[5.0]
  def change
  	add_column :networks, :differentiator, :text
  end
end
