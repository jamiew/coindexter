class ChangeTitleInWhitepapers < ActiveRecord::Migration[5.0]
  def change
    rename_column :whitepapers, :title, :whitepaper_title
  end
end
