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
<<<<<<< Updated upstream
    assert_redirected_to root_url
=======
    assert_redirected_to root_path
>>>>>>> Stashed changes
  end

  test "should get cancel" do
    get cancel_subscriptions_url
<<<<<<< Updated upstream
    assert_redirected_to root_url
=======
    assert_redirected_to root_path
>>>>>>> Stashed changes
  end

  test "should execute create monthly" do
    post subscriptions_url, params: { plan: "monthly" }
    assert_redirected_to "https://example.com/checkout"
  end

  test "should execute create yearly" do
    post subscriptions_url, params: { plan: "yearly" }
    assert_redirected_to "https://example.com/checkout"
  end
end
