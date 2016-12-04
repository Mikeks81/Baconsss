class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :text_user_interval
      t.integer :response_time
      t.integer :text_contact_time

      t.timestamps
    end
  end
end
