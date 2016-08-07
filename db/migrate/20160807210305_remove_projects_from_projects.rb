class RemoveProjectsFromProjects < ActiveRecord::Migration[5.0]
  def change
  	remove_columns :projects, :project
  end
end
