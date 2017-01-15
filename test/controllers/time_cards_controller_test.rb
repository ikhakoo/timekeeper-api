require 'test_helper'

class TimeCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_card = time_cards(:one)
  end

  test "should get index" do
    get time_cards_url, as: :json
    assert_response :success
  end

  test "should create time_card" do
    assert_difference('TimeCard.count') do
      post time_cards_url, params: { time_card: { occurrence: @time_card.occurrence, username: @time_card.username } }, as: :json
    end

    assert_response 201
  end

  test "should show time_card" do
    get time_card_url(@time_card), as: :json
    assert_response :success
  end

  test "should update time_card" do
    patch time_card_url(@time_card), params: { time_card: { occurrence: @time_card.occurrence, username: @time_card.username } }, as: :json
    assert_response 200
  end

  test "should destroy time_card" do
    assert_difference('TimeCard.count', -1) do
      delete time_card_url(@time_card), as: :json
    end

    assert_response 204
  end
end
