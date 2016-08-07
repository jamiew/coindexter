class RemoveApplicationAttributesFromCoins < ActiveRecord::Migration[5.0]
  def change
  	remove_columns :coins, :application_name, :application_status, :application_url, :has_application
  end
end
