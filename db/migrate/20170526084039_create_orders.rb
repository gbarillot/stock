class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.timestamps
      t.string :reference
      t.string :name
      t.string :barcode
      t.integer :created_by
      t.integer :user_id
      t.datetime :due_at
    end

    create_table :orders_positions do |t|
      t.timestamps
      t.integer :position_id
      t.integer :order_id
    end
  end
end
