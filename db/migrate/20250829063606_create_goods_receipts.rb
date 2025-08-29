class CreateGoodsReceipts < ActiveRecord::Migration[8.0]
  def change
    create_table :goods_receipts do |t|
      t.string :gr_number, null: false
      t.string :po_reference, null: false
      t.date :receipt_date, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.text :notes
      t.boolean :quality_approved, default: false
      t.string :quality_notes
      
      # SAP Integration fields
      t.string :sap_document_number
      t.datetime :sap_posted_at
      t.text :sap_response

      t.timestamps
    end

    add_index :goods_receipts, :gr_number, unique: true
    add_index :goods_receipts, :po_reference
    add_index :goods_receipts, [:status, :receipt_date]
    add_index :goods_receipts, :sap_document_number
  end
end
