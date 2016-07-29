class ChangeEmailInUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :users, :email, ""
  	change_column_null :users, :email, false
  end
end
