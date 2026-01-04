require "test_helper"

class MypagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:owner)
  end

  test "should get show" do
    get mypage_url
    assert_response :success
  end
end
