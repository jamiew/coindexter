class AddUrlsToWhitepapers < ActiveRecord::Migration[5.0]
  def change
  	add_column :whitepapers, :url, :string
  end
end
