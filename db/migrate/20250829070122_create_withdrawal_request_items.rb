class CreateWithdrawalRequestItems < ActiveRecord::Migration[8.0]
  def change
    create_table :withdrawal_request_items do |t|
      t.references :withdrawal_request, null: false, foreign_key: true
      t.references :goods_receipt_item, null: false, foreign_key: true
      t.decimal :requested_quantity, precision: 12, scale: 3, null: false
      t.text :notes

      t.timestamps
    end

    add_index :withdrawal_request_items, [:withdrawal_request_id, :goods_receipt_item_id], 
              unique: true, name: 'idx_wr_items_unique'
  end
end
