class AddFulfillStatusToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :fulfilled_status, :boolean, default: false
  end
end
