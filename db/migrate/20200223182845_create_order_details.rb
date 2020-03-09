class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.belongs_to :product
      t.belongs_to :order
      t.float :price
      t.integer :quantity
      t.timestamps
    end
  end
end
