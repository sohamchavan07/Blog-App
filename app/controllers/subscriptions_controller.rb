class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @plans = {}

    { monthly: ENV["STRIPE_MONTHLY_PRICE_ID"], yearly: ENV["STRIPE_YEARLY_PRICE_ID"] }.each do |key, env_price|
      # Prefer Price ID; otherwise fall back to amount cents
      plan = { id: nil, amount_cents: nil, currency: (ENV["STRIPE_CURRENCY"] || "usd") }

      if env_price.present? && env_price.start_with?("price_")
        begin
          price = Stripe::Price.retrieve(env_price)
          plan[:id] = env_price
          plan[:amount_cents] = price.unit_amount
          plan[:currency] = price.currency
        rescue => e
          # If Stripe API fails, fallback to env amounts
          plan[:id] = nil
        end
      end

      if plan[:amount_cents].nil?
        env_amount = key == :yearly ? ENV["STRIPE_YEARLY_AMOUNT_CENTS"] : ENV["STRIPE_MONTHLY_AMOUNT_CENTS"]
        plan[:amount_cents] = (env_amount || (key == :yearly ? 5000 : 500)).to_i
      end

      # Human-readable formatted price
      plan[:formatted_price] = sprintf("$%d", plan[:amount_cents] / 100)
      @plans[key] = plan
    end
  end

  def create
    price_id = params[:plan] == "yearly" ? ENV["STRIPE_YEARLY_PRICE_ID"] : ENV["STRIPE_MONTHLY_PRICE_ID"]
    # Only treat the env value as a Price ID when it looks like one (starts with "price_")
    price_id = nil unless price_id.present? && price_id.start_with?("price_")

    # Build line item: prefer configured Price ID, fallback to price_data if missing
    if price_id.present?
      line_item = { price: price_id, quantity: 1 }
    else
      # Fallback amounts (in cents) and currency — prefer ENV values if provided
      if params[:plan] == "yearly"
        amount = (ENV["STRIPE_YEARLY_AMOUNT_CENTS"] || ENV["STRIPE_YEARLY_AMOUNT"] || 5000).to_i
        interval = "year"
        product_name = ENV["STRIPE_YEARLY_PRODUCT_NAME"] || "Yearly Subscription"
      else
        amount = (ENV["STRIPE_MONTHLY_AMOUNT_CENTS"] || ENV["STRIPE_MONTHLY_AMOUNT"] || 500).to_i
        interval = "month"
        product_name = ENV["STRIPE_MONTHLY_PRODUCT_NAME"] || "Monthly Subscription"
      end

      line_item = {
        price_data: {
          currency: (ENV["STRIPE_CURRENCY"] || "usd"),
          unit_amount: amount,
          recurring: { interval: interval },
          product_data: { name: product_name }
        },
        quantity: 1
      }
    end

    session_params = {
      payment_method_types: [ "card" ],
      line_items: [ line_item ],
      mode: "subscription",
      success_url: success_subscriptions_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_subscriptions_url
    }

    # Only include `customer` if we have one; otherwise use customer_email
    if current_user.stripe_customer_id.present?
      session_params[:customer] = current_user.stripe_customer_id
    else
      session_params[:customer_email] = current_user.email
    end

    session = Stripe::Checkout::Session.create(session_params)

    # Save customer ID if not already saved
    current_user.update(stripe_customer_id: session.customer) if current_user.stripe_customer_id.nil?

    redirect_to session.url, allow_other_host: true
  end

  def success
    if params[:session_id].present?
      session = Stripe::Checkout::Session.retrieve(params[:session_id])
      # We rely on webhooks for the source of truth, but we can do a quick update here
      current_user.update(
        stripe_subscription_id: session.subscription,
        subscription_status: "active" # Provisional update
      )
    end
    redirect_to root_path, notice: "Thank you for subscribing!"
  end

  def cancel
    redirect_to root_path, alert: "Subscription cancelled."
  end
end
