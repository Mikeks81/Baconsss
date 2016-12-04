class AddActiveToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :active, :boolean
  end
end
