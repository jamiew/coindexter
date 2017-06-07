class AddExternalUrlToWhitepapers < ActiveRecord::Migration[5.0]
  def change
  	add_column :whitepapers, :external_url, :string
  end
end
