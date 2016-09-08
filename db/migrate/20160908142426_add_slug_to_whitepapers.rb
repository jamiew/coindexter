class AddSlugToWhitepapers < ActiveRecord::Migration[5.0]
  def change
    add_column :whitepapers, :slug, :string
  end
end
