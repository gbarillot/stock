class RenameBasket < ActiveRecord::Migration[5.1]
  def change
    rename_table :orders_positions, :baskets
  end
end
