class AddEmailToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :email, :string
  end
end
