class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :item_code, null: false
      t.string :description, null: false
      t.string :category
      t.string :unit_of_measure, default: 'EA'
      t.decimal :unit_weight, precision: 10, scale: 3
      t.decimal :standard_cost, precision: 12, scale: 2
      t.boolean :active, default: true
      t.string :barcode
      t.text :notes
      
      # SAP Integration fields
      t.string :sap_item_code
      t.datetime :last_sap_sync

      t.timestamps
    end

    add_index :items, :item_code, unique: true
    add_index :items, :barcode, unique: true, where: "barcode IS NOT NULL"
    add_index :items, :sap_item_code
    add_index :items, [:category, :active]
  end
end
