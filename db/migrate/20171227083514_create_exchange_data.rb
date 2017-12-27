class CreateExchangeData < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_data do |t|
      t.date :date, null: false
      t.float :coef, null: false

      t.timestamps
    end
    add_index :exchange_data, :date, unique: true
  end
end
