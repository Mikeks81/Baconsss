class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :transmission
      t.references :user, foreign_key: true
      t.text :body
      t.string :to
      t.string :from
      t.string :location

      t.timestamps
    end
  end
end
