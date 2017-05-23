class DbRewrite < ActiveRecord::Migration[5.1]
  def change
    rename_column :positions, :depth, :parent_id
    add_column :positions, :product_id, :integer, default: nil
    add_column :products, :ean13, :string, default: nil
    remove_column :products, :position
  end
end
