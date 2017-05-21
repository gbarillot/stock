class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.timestamps
      t.string :reference
      t.string :name
      t.integer :quantity, default: 0
      t.string :position
    end

    create_table :positions do |t|
      t.timestamps
      t.string :name
      t.integer :depth, default: 0
      t.integer :quantity
    end
  end
end
