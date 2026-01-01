require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:owner)
  end

  test "should get show" do
    get account_url
    assert_response :success
  end

  test "should get edit" do
    get edit_account_url
    assert_response :success
  end
end
