class CreateJoinTableNetworksLinks < ActiveRecord::Migration[5.0]
  def change
    create_join_table :networks, :links do |t|
      t.index [:network_id, :link_id]
      t.index [:link_id, :network_id]
    end
  end
end
