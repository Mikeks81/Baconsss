class ChangePhoneTypeToPhoneType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :phones, :type, :phone_type
  end
end
