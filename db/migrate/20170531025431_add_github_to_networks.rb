class AddGithubToNetworks < ActiveRecord::Migration[5.0]
  def change
  	add_column :networks, :github, :string
  end
end
