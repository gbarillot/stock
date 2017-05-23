class AddDepthToPositions < ActiveRecord::Migration[5.1]
  def change
    rename_column :positions, :parent_id, :depth
  end
end
