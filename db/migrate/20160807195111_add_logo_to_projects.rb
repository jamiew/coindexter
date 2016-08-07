class AddLogoToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project, :string
  end
end
