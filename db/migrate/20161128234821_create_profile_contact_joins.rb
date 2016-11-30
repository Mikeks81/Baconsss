class CreateProfileContactJoins < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_contact_joins do |t|
      t.references :profile, foreign_key: true
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
