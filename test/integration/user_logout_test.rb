require_relative "../test_helper"

class UserLogoutTest < ActionDispatch::IntegrationTest
  def test_logged_in_user_can_log_out
    user = User.create(username: "william", password: "password")

    visit login_path

    fill_in "Username", with: "william"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Welcome, william")

    click_link "Logout"

    refute page.has_content?("Welcome, william")
  end
end
