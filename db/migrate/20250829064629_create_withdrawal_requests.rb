class CreateWithdrawalRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :withdrawal_requests do |t|
      t.string :wr_number, null: false
      t.references :user, null: false, foreign_key: true
      t.references :business_unit, null: false, foreign_key: true
      t.references :goods_receipt, null: false, foreign_key: true
      t.date :request_date, null: false
      t.date :required_date
      t.integer :status, default: 0
      t.integer :priority, default: 1
      t.text :purpose
      t.text :notes

      t.timestamps
    end

    add_index :withdrawal_requests, :wr_number, unique: true
    add_index :withdrawal_requests, [:status, :request_date]
  end
end
