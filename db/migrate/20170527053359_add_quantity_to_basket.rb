class AddQuantityToBasket < ActiveRecord::Migration[5.1]
  def change
    add_column :baskets, :quantity, :integer, default: 0
  end
end
