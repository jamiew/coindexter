class CreateLinksNetworks < ActiveRecord::Migration[5.1]
  def change
  	drop_table :links_networks
    create_table :links_networks do |t|
      t.references :network, foreign_key: true
      t.references :link, foreign_key: true
    end
  end
end
