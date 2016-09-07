class AddTitleToWhitepapers < ActiveRecord::Migration[5.0]
  def change
    add_column :whitepapers, :title, :string
  end
end
