class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :fraternity, foreign_key: true
      t.integer :role, null: false
      t.string :nickname

      t.timestamps
    end
  end
end
