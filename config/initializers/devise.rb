require "devise/orm/active_record"

Devise.setup do |config|
  # Default sender used by Devise mailer.
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  # Use bcrypt for password hashing.
  config.stretches = Rails.env.test? ? 1 : 12

  # Reconfirm email when changing address.
  config.reconfirmable = true

  # Time window where reset password token remains valid.
  config.reset_password_within = 6.hours

  # Keep user signed in for this duration when remember me is checked.
  config.remember_for = 2.weeks
end
