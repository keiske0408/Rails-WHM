class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :first_name,         null: false
      t.string :last_name,          null: false
      t.string :employee_id,        null: false
      t.integer :role,              default: 0
      t.boolean :active,            default: true
      t.references :business_unit, null: true, foreign_key: true

      # Two-factor authentication
      t.string   :encrypted_otp_secret
      t.string   :encrypted_otp_secret_iv
      t.string   :encrypted_otp_secret_salt
      t.integer  :consumed_timestep
      t.boolean  :otp_required_for_login, default: false

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.datetime :last_sign_in_at
      t.datetime :current_sign_in_at
      t.string   :last_sign_in_ip
      t.string   :current_sign_in_ip

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :employee_id, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
