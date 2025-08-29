class CreateApprovals < ActiveRecord::Migration[8.0]
  def change
    create_table :approvals do |t|
      t.references :withdrawal_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false
      t.datetime :approval_date, null: false
      t.text :notes

      t.timestamps
    end

    add_index :approvals, [:withdrawal_request_id, :user_id]
    add_index :approvals, :approval_date
  end
end
