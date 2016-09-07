class CreateWhitepapers < ActiveRecord::Migration[5.0]
  def change
    create_table :whitepapers do |t|
      t.integer :network_id
      t.string :whitepaper
      t.timestamps
    end
  end
end
