class CreateJoinTableCoinsLinks < ActiveRecord::Migration[5.0]
  def change
    create_join_table :coins, :links do |t|
      t.index [:coin_id, :link_id]
      t.index [:link_id, :coin_id]
    end
  end
end
