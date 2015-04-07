require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "S!mple ERP"
    assert_equal full_title("Help"), "Help | S!mple ERP"
  end
end