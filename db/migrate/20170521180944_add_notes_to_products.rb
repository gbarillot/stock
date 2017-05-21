class AddNotesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :notes, :string
  end
end
