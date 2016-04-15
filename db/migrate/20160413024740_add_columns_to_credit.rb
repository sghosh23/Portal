class AddColumnsToCredit < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :user_id
      t.decimal :amount
      t.string :card_name
      t.integer :card_number
      t.integer :month
      t.integer :year
      t.integer :security
      t.timestamps null: false
    end
    add_index :credits, :user_id
  end
end
