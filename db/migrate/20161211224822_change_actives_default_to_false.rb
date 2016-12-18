class ChangeActivesDefaultToFalse < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :active, :boolean, default: false
  	change_column :profiles, :active, :boolean, default: false
  end
end
