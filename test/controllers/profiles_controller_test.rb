require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:owner)
  end

  test "should get edit" do
    get edit_profile_url
    assert_response :success
  end
end
