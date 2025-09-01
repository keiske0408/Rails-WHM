class CreateGoodsIssuanceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :goods_issuance_items do |t|
      t.references :goods_issuance, null: false, foreign_key: true, index: false
      t.references :withdrawal_request_item, null: false, foreign_key: true, index: false
      t.decimal :issued_quantity, precision: 12, scale: 3, null: false
      t.text :notes
      t.string :barcode_scanned
      t.datetime :scanned_at

      t.timestamps
    end

    add_index :goods_issuance_items, [:goods_issuance_id, :withdrawal_request_item_id], 
              unique: true, name: 'idx_gi_items_unique'
    add_index :goods_issuance_items, :barcode_scanned
  end
end
