class AddWhitepaperTitleToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :whitepaper_title, :string
    add_column :projects, :whitepaper_url, :string
  end
end
