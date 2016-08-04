class AddLinksToCoin < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :link_id, :integer
  end
end
