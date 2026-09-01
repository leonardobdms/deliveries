class CreateDeliveries < ActiveRecord::Migration[8.1]
  def change
    create_table :deliveries do |t|
      t.integer :order_id, null: false
      t.string :status, null: false, default: 'pending'
      t.string :address, null: false

      t.timestamps
    end
  end
end
