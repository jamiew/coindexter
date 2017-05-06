class AddUserIdToWhitepapers < ActiveRecord::Migration[5.0]
  def change
    add_column :whitepapers, :user_id, :integer
  end
end
