class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.timestamps
      t.integer :user_id
      t.integer :item_id
      t.string :item_type
      t.jsonb :actions
    end
  end
end
