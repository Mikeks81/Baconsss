require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index,show," do
    get users_index,show,_url
    assert_response :success
  end

  test "should get edit," do
    get users_edit,_url
    assert_response :success
  end

  test "should get update," do
    get users_update,_url
    assert_response :success
  end

  test "should get destroy" do
    get users_destroy_url
    assert_response :success
  end

end
