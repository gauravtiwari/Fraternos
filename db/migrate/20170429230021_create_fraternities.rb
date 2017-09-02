class CreateFraternities < ActiveRecord::Migration[5.1]
  def change
    create_table :fraternities do |t|
      t.string :name, null: false
      t.decimal :absent_penalty, precision: 8, scale: 2, null: false, default: 0.0
      t.timestamps
    end
  end
end
