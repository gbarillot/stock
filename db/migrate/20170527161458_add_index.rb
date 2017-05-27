class AddIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :baskets, :position_id
    add_index :baskets, :order_id

    add_index :orders, :reference
    add_index :orders, :user_id

    add_index :positions, :name
    add_index :positions, :quantity
    add_index :positions, :product_id
    add_index :positions, :free

    add_index :products, :reference
    add_index :products, :name
    add_index :products, :quantity
  end
end
