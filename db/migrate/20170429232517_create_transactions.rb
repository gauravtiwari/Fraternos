class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.date :date, null: false
      t.decimal :amount, precision: 2, null: false
      t.references :fraternity, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
