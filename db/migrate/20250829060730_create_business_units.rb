class CreateBusinessUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :business_units do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.boolean :active, default: true
      t.string :manager_email
      t.string :contact_person
      t.string :phone_number

      t.timestamps
    end

    add_index :business_units, :code, unique: true
    add_index :business_units, :name
  end
end
