class AddWidthAndHeightToWhitepaper < ActiveRecord::Migration[5.0]
  def change
  	add_column :whitepapers, :width, :integer
  	add_column :whitepapers, :height, :integer
  end
end
