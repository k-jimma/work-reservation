require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
    sign_in users(:guest)
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_room_reservation_url(rooms(:one))
    assert_response :success
  end

  test "should get show" do
    get reservation_url(@reservation)
    assert_response :success
  end
end
