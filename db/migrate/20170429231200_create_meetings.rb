class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.references :fraternity, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end
  end
end
