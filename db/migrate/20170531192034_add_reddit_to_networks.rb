class AddRedditToNetworks < ActiveRecord::Migration[5.0]
  def change
  	add_column :networks, :reddit, :string
  end
end
