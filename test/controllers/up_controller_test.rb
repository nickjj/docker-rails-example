require "test_helper"

class UpControllerTest < ActionDispatch::IntegrationTest
  test "should get up" do
    get up_url
    assert_response :success
  end

  test "should get up databases" do
    get up_databases_url
    assert_response :success
  end
end
