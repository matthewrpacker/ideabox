require "test_helper"

class UserCanSeeOnlyTheirOwnIdeasTest < ActionDispatch::IntegrationTest
  def test_user_can_see_only_their_own_ideas
    user1 = User.create(username: "matthew", password: "password")
    user2 = User.create(username: "david", password: "password")

    user1.ideas.create(name: "Ski Lift App", description: "Monitors lift lines")
    user2.ideas.create(name: "Golf App", description: "Monitors pace of play")

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit user_ideas_path(user1)
    assert page.has_content?("Ski")
    refute page.has_content?("Golf")

    visit user_ideas_path(user2)

    assert page.has_content?("matthew")
    refute page.has_content?("david")
  end
end
