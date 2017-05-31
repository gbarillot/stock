class AddVolumeToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :volume, :integer, default: 0
    add_column :positions, :width, :integer, default: 0
    add_column :positions, :height, :integer, default: 0
    add_column :positions, :level, :integer, default: 0
  end
end
