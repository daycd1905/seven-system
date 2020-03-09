class ChangeComlumnOrderDetails < ActiveRecord::Migration[6.0]
  def change
    rename_column :order_details, :ptice, :price
  end
end
