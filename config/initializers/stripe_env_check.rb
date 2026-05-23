required = %w[STRIPE_SECRET_KEY STRIPE_PUBLISHABLE_KEY]
missing = required.select { |k| ENV[k].nil? || ENV[k].strip.empty? }

if Rails.env.production? && missing.any?
  Rails.logger.warn("Stripe env missing: #{missing.join(', ')}. Subscriptions may fail in production.")
end

if ENV["STRIPE_WEBHOOK_SECRET"].nil? || ENV["STRIPE_WEBHOOK_SECRET"].strip.empty?
  Rails.logger.info("STRIPE_WEBHOOK_SECRET not set - webhooks will be rejected unless configured.")
end
