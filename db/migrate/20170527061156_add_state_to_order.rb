class AddStateToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :state, :string, default: 'busy'
  end
end
