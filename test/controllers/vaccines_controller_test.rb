require 'test_helper'

class VaccinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vaccines_index_url
    assert_response :success
  end

end
