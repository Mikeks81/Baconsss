class AddLocationRoleToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :location_role, :string
  end
end
