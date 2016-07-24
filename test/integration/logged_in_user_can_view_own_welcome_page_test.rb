require "test_helper"

class LoggedInUserCanViewOwnWelcomePageTest < ActionDispatch::IntegrationTest
  def test_logged_in_user_can_view_own_welcome_page
    user = User.create(username: "matthew", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit user_path(user)

    assert page.has_content?("Welcome, matthew")
  end
end
