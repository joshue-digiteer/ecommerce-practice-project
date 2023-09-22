require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get payments_index_url
    assert_response :success
  end

  test "should get show" do
    get payments_show_url
    assert_response :success
  end

  test "should get new" do
    get payments_new_url
    assert_response :success
  end

  test "should get create" do
    get payments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get payments_destroy_url
    assert_response :success
  end
end
