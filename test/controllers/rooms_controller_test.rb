require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:owner)
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get show" do
    room = rooms(:one)
    get room_url(room)
    assert_response :success
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end

  test "should get edit" do
    room = rooms(:one)
    get edit_room_url(room)
    assert_response :success
  end

  test "should get mine" do
    get mine_rooms_url
    assert_response :success
  end
end
