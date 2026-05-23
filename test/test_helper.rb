ENV["RAILS_ENV"] ||= "test"
# Provide a test Stripe secret key so the initializer can set Stripe.api_key in tests
ENV["STRIPE_SECRET_KEY"] ||= "sk_test_1234567890"
require_relative "../config/environment"
require "rails/test_help"

require "ostruct"

# Stub Stripe API calls in test environment to avoid network calls and API key validation
if Rails.env.test?
  Stripe::Checkout::Session.define_singleton_method(:create) do |params|
    OpenStruct.new(url: "https://example.com/checkout", customer: "cus_test", id: "cs_test", subscription: "sub_test")
  end

  Stripe::Checkout::Session.define_singleton_method(:retrieve) do |id|
    OpenStruct.new(subscription: "sub_test", customer: "cus_test")
  end

  Stripe::Price.define_singleton_method(:retrieve) do |id|
    OpenStruct.new(unit_amount: 500, currency: "usd")
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
