require 'test_helper'

class UsersHelperTest < ActionView::TestCase

  test "gravatar_url_for should also work with nil addresses" do
    assert_not_nil gravatar_url_for(nil)
  end

end
