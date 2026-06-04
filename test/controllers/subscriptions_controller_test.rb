# test/controllers/subscriptions_controller_test.rb
require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get new_subscription_url
    assert_response :success
  end

  test "should get success" do
    get success_subscriptions_url
    assert_redirected_to root_url
  end

  test "should get cancel" do
    get cancel_subscriptions_url
    assert_redirected_to root_url
  end

  test "should execute create" do
    # In RESTful routing, creating a resource uses a POST request, not a GET
    post subscriptions_url, params: {}

    # Adjust this assertion depending on whether your controller redirects to Stripe/Success or renders a page
    assert_response :redirect
  end
end
