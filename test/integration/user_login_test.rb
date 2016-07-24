require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def test_registered_user_can_login
    user = User.create(username: "david", password: "password")

    visit login_path

    fill_in "Username", with: "david"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Welcome, david")
  end

  def test_logged_in_user_can_view_own_welcome_page
    user = User.create(username: "matthew", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit user_path(user)

    assert page.has_content?("Welcome, matthew")
  end

  def test_unregistered_user_cannot_view_welcome_page_of_different_user
    user = User.create(username: "matthew", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(nil)

    visit user_path(user)

    within(".flash_alert") do
      assert page.has_content?("Not authorized")
    end
  end

  def test_registered_user_cannot_view_welcome_page_of_different_user
    user1 = User.create(username: "matthew", password: "password")
    user2 = User.create(username: "david", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit user_path(user2)

    within(".flash_alert") do
      assert page.has_content?("Not authorized")
    end
  end
end
