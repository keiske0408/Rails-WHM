FactoryBot.define do
  factory :user do
    email { "MyString" }
    encrypted_password { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    employee_id { "MyString" }
    role { 1 }
    active { false }
    business_unit { nil }
    encrypted_otp_secret { "MyString" }
    encrypted_otp_secret_iv { "MyString" }
    encrypted_otp_secret_salt { "MyString" }
    consumed_timestep { 1 }
    otp_required_for_login { false }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2025-08-29 06:07:34" }
    remember_created_at { "2025-08-29 06:07:34" }
    last_sign_in_at { "2025-08-29 06:07:34" }
    current_sign_in_at { "2025-08-29 06:07:34" }
    last_sign_in_ip { "MyString" }
    current_sign_in_ip { "MyString" }
  end
end
