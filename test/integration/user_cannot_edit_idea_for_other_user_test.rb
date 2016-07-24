require "test_helper"

class UserCannotEditIdeaForOtherUserTest < ActionDispatch::IntegrationTest
  def test_user_cannot_edit_idea_for_other_user
    user1 = User.create(username: "matt", password: "password")
    user2 = User.create(username: "dave", password: "password")

    idea1 = user1.ideas.create(name: "Ski Lift App", description: "Monitors lift lines")
    idea2 = user2.ideas.create(name: "Golf App", description: "Monitors pace of play")

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit edit_user_idea_path(user2, idea2)
    assert page.has_content?("Login")
    refute page.has_content?("dave")
  end
end
