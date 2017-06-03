class AddPickedToBaskets < ActiveRecord::Migration[5.1]
  def change
    add_column :baskets, :picked, :boolean, default: false
  end
end
