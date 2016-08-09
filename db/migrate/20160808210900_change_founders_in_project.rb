class ChangeFoundersInProject < ActiveRecord::Migration[5.0]
  def change
  	change_column :projects, :founders, "varchar[] USING (string_to_array(founders, ','))"
  end
end
