require "test_helper"

class UserCannotCreateIdeaForOtherUserTest < ActionDispatch::IntegrationTest
  def test_user_cannot_create_idea_for_other_user
    user1 = User.create(username: "matthew", password: "password")
    user2 = User.create(username: "david", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit new_user_idea_path(user2)
    assert page.has_content?("Welcome, matthew")
    refute page.has_content?("Welcome, david")
  end
end
