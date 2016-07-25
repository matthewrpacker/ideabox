require "test_helper"

class UserCanDeleteTheirOwnIdeasTest < ActionDispatch::IntegrationTest
  def test_user_can_delete_their_own_ideas
    user = User.create(username: "matthew", password: "password")
    idea = user.ideas.create(name: "Golf App", description: "Reports pace of play")

    visit login_path

    fill_in "Username", with: "matthew"
    fill_in "Password", with: "password"
    click_button "Login"

    visit user_idea_path(user, idea)

    assert page.has_content?("Golf App")

    click_on "Delete"

    assert current_path, user_ideas_path(user)
    refute page.has_content?("Golf App")
  end
end
