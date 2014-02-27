require 'test_helper'

class SaleRecordsControllerTest < ActionController::TestCase
  # Test of the controller that manages data uploads
  test "should get index" do
    get :index
    assert_response :success
  end

  def test_should_execute_upload_action
    # Test that the system is able to upload a file and respond
    post :upload_action,
      :upload => { 'datafile' => fixture_file_upload('/example_input.tab', 'text/txt')}
    assert_response :success
    # The gross revenue amount is $95 in the test file
    assert_equal(95.00, assigns(:total_amount_gross_revenue))
  end
end
