require 'test_helper'

class PhonesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get phones_create_url
    assert_response :success
  end

  test "should get update" do
    get phones_update_url
    assert_response :success
  end

  test "should get destroy" do
    get phones_destroy_url
    assert_response :success
  end

end
