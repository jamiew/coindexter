class ChangeWhitepapersInNetworks2 < ActiveRecord::Migration[5.0]
  def change
    change_column :networks, :whitepapers, :json
  end
end
