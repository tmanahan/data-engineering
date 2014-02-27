require 'test_helper'

class MenuControllerTest < ActionController::TestCase
  # There is only one function in the menu controller
  test "should get index" do
    get :index
    assert_response :success
  end
end
