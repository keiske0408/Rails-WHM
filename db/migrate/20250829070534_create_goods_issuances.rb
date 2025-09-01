class CreateGoodsIssuances < ActiveRecord::Migration[8.0]
  def change
    create_table :goods_issuances do |t|
      t.string :gi_number, null: false
      t.references :withdrawal_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :issue_date, null: false
      t.integer :status, default: 0
      t.text :notes
      
      # SAP Integration fields
      t.string :sap_document_number
      t.datetime :sap_posted_at
      t.text :sap_response

      t.timestamps
    end

    add_index :goods_issuances, :gi_number, unique: true
    # These two are redundant (Rails auto-indexes t.references), but you can leave them if you want control:
    # add_index :goods_issuances, :withdrawal_request_id
    add_index :goods_issuances, [:status, :issue_date]
    add_index :goods_issuances, :sap_document_number
  end
end
