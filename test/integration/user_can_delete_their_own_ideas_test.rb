require "test_helper"

class UserCanDeleteTheirOwnIdeasTest < ActionDispatch::IntegrationTest
  def test_can_delete_their_own_ideas
    user = User.create(username: "matthew", password: "password")
    idea = user.ideas.create(name: "Golf App", description: "Reports pace of play")

    visit login_path

    fill_in "Username", with: "matthew"
    fill_in "Password", with: "password"
    click_button "Login"

    visit user_idea_path(user, idea)

    assert page.has_content?("Golf App")

    click_link "Delete"

    assert current_path, user_ideas_path(user)
    refute page.has_content?("Golf App")
  end

  def test_cannot_delete_ideas_of_other_users
    user1 = User.create(username: "matt", password: "password")
    user2 = User.create(username: "dave", password: "password")

    idea1 = user1.ideas.create(name: "Ski Lift App", description: "Monitors lift lines")
    idea2 = user2.ideas.create(name: "Golf App", description: "Monitors pace of play")

    ApplicationController.any_instance.stubs(:current_user).returns(user1)

    visit user_idea_path(user2, idea2)

    assert page.has_content?("Login")

    refute page.has_content?("Golf App")
  end
end
