class CreateJoinTableUserLink2 < ActiveRecord::Migration[5.1]
  def change
  	  create_join_table :users, :links do |t|
      t.index [:user_id, :link_id]
      t.index [:link_id, :user_id]
    end
  end
end
