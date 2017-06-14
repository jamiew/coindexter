class RemoveDifferentiatorFromNetworks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :networks, :differentiator
  end
end
