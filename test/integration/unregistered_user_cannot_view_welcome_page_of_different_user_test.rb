require "test_helper"

class UnregisteredUserCannotViewWelcomePageOfDifferentUserTest < ActionDispatch::IntegrationTest
  def test_unregistered_user_cannot_view_welcome_page_of_different_user
    user = User.create(username: "matthew", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(nil)

    visit user_path(user)

    within(".flash_alert") do
      assert page.has_content?("Not authorized")
    end
  end
end
