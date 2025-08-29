class CreateInventoryLevels < ActiveRecord::Migration[8.0]
   def change
    create_table :inventory_levels do |t|
      t.references :item, null: false, foreign_key: true
      t.string :warehouse_location
      t.string :batch_lot
      t.decimal :total_quantity, precision: 12, scale: 3, default: 0
      t.decimal :available_quantity, precision: 12, scale: 3, default: 0
      t.decimal :reserved_quantity, precision: 12, scale: 3, default: 0
      t.decimal :reorder_level, precision: 12, scale: 3, default: 0
      t.decimal :maximum_level, precision: 12, scale: 3
      t.decimal :unit_cost, precision: 12, scale: 2
      t.decimal :average_monthly_usage, precision: 12, scale: 3, default: 0
      t.date :last_receipt_date
      t.date :last_issue_date
      t.datetime :last_updated

      t.timestamps
    end

    add_index :inventory_levels, [:item_id, :warehouse_location, :batch_lot], 
              unique: true, name: 'idx_inventory_unique'
    add_index :inventory_levels, :warehouse_location
    add_index :inventory_levels, :available_quantity
    add_index :inventory_levels, [:item_id, :available_quantity]
  end
end
