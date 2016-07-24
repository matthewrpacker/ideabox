require_relative "../test_helper"

class UserCreationTest < ActionDispatch::IntegrationTest
  test "a user can be created" do
    visit new_user_path

    fill_in "Username", with: "matthew"
    fill_in "Password", with: "password"
    click_on "Create Account"

    assert page.has_content?("Welcome, matthew")
  end
end
