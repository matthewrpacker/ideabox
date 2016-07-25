require "test_helper"

class RegisteredUserCannotViewWelcomePageOfDifferentUserTest < ActionDispatch::IntegrationTest
  def test_registered_user_cannot_view_welcome_page_of_different_user
    user1 = User.create(username: "matthew", password: "password")
    user2 = User.create(username: "david", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit user_path(user2)

    within(".flash_alert") do
      assert page.has_content?("Unauthorized")
    end
  end
end
