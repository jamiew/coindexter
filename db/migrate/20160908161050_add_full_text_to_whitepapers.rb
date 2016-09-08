class AddFullTextToWhitepapers < ActiveRecord::Migration[5.0]
  def change
    add_column :whitepapers, :fulltext, :text
  end
end
