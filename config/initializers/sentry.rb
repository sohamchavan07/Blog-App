# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://2d965ad165863dbd3230ef044ae3b166@o4511303396950016.ingest.us.sentry.io/4511303398195200'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end

begin
  1 / 0
rescue ZeroDivisionError => exception
  Sentry.capture_exception(exception)
end

Sentry.capture_message("test message")
