class CreateGoodsReceiptItems < ActiveRecord::Migration[8.0]
  def change
    create_table :goods_receipt_items do |t|
      t.references :goods_receipt, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :quantity, precision: 12, scale: 3, null: false
      t.decimal :unit_price, precision: 12, scale: 2, null: false
      t.string :warehouse_location
      t.string :batch_lot
      t.decimal :available_quantity, precision: 12, scale: 3, null: false
      t.text :remarks
      t.boolean :quality_passed, default: true
      t.string :inspection_notes

      t.timestamps
    end

    add_index :goods_receipt_items, [:goods_receipt_id, :item_id], unique: true
    add_index :goods_receipt_items, :warehouse_location
    add_index :goods_receipt_items, :batch_lot
  end
end
