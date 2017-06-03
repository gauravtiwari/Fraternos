class CreateOrganizerAssignations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizer_assignations do |t|
      t.references :organizer, foreign_key: { to_table: :users }
      t.references :meeting, foreign_key: true

      t.timestamps
    end

    add_index :organizer_assignations, [:organizer_id, :meeting_id], unique: true
  end
end
