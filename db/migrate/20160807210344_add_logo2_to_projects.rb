class AddLogo2ToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :logo, :string
  end
end
