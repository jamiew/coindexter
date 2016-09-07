require 'test_helper'

class WhitepapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @whitepaper = whitepapers(:one)
  end

  test "should get index" do
    get whitepapers_url
    assert_response :success
  end

  test "should get new" do
    get new_whitepaper_url
    assert_response :success
  end

  test "should create whitepaper" do
    assert_difference('Whitepaper.count') do
      post whitepapers_url, params: { whitepaper: { post_id: @whitepaper.post_id, whitepaper: @whitepaper.whitepaper } }
    end

    assert_redirected_to whitepaper_url(Whitepaper.last)
  end

  test "should show whitepaper" do
    get whitepaper_url(@whitepaper)
    assert_response :success
  end

  test "should get edit" do
    get edit_whitepaper_url(@whitepaper)
    assert_response :success
  end

  test "should update whitepaper" do
    patch whitepaper_url(@whitepaper), params: { whitepaper: { post_id: @whitepaper.post_id, whitepaper: @whitepaper.whitepaper } }
    assert_redirected_to whitepaper_url(@whitepaper)
  end

  test "should destroy whitepaper" do
    assert_difference('Whitepaper.count', -1) do
      delete whitepaper_url(@whitepaper)
    end

    assert_redirected_to whitepapers_url
  end
end
