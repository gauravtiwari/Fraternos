class CreateAttendanceRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_records do |t|
      t.references :meeting, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :presence, default: false

      t.timestamps
    end

    add_index :attendance_records, [:meeting_id, :user_id], unique: true
  end
end
