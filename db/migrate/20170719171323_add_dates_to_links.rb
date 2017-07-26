class AddDatesToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :created_at, :datetime
    add_column :links, :updated_at, :datetime
  end
end
