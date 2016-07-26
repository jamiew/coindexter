class AddApplicationUrlToCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :coins, :application_url, :string
  end
end
