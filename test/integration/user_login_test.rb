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
end
