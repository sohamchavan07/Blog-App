module Stripe
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      payload = request.body.read
      sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
      endpoint_secret = ENV["STRIPE_WEBHOOK_SECRET"]

      event = nil

      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, endpoint_secret
        )
      rescue JSON::ParserError => e
        render json: { error: "Invalid payload" }, status: 400
        return
      rescue Stripe::SignatureVerificationError => e
        render json: { error: "Invalid signature" }, status: 400
        return
      end

      # Handle the event
      case event.type
      when "customer.subscription.created", "customer.subscription.updated"
        subscription = event.data.object
        handle_subscription_change(subscription)
      when "customer.subscription.deleted"
        subscription = event.data.object
        handle_subscription_deletion(subscription)
      end

      render json: { message: "success" }
    end

    private

    def handle_subscription_change(subscription)
      customer_id = subscription.customer
      user = User.find_by(stripe_customer_id: customer_id)

      if user
        user.update(
          subscription_status: subscription.status,
          stripe_subscription_id: subscription.id
        )
      end
    end

    def handle_subscription_deletion(subscription)
      customer_id = subscription.customer
      user = User.find_by(stripe_customer_id: customer_id)

      if user
        user.update(
          subscription_status: "canceled",
          stripe_subscription_id: nil
        )
      end
    end
  end
end
