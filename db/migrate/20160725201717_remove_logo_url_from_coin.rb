class RemoveLogoUrlFromCoin < ActiveRecord::Migration[5.0]
  def change
    remove_column :coins, :logo_url, :string
  end
end
