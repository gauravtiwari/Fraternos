class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.references :membership, foreign_key: true

      t.timestamps
    end
  end
end
