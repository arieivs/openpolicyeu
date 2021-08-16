require "test_helper"

class PolicyMakingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get policy_makings_show_url
    assert_response :success
  end

  test "should get new" do
    get policy_makings_new_url
    assert_response :success
  end

  test "should get create" do
    get policy_makings_create_url
    assert_response :success
  end

  test "should get edit" do
    get policy_makings_edit_url
    assert_response :success
  end

  test "should get update" do
    get policy_makings_update_url
    assert_response :success
  end
end
