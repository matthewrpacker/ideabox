require "test_helper"

class UserCanEditTheirOwnIdeasTest < ActionDispatch::IntegrationTest
  def test_user_can_edit_their_own_idea
    user = User.create(username: "matthew", password: "password")
    idea = user.ideas.create(name: "Golf App", description: "Reports pace of play")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit edit_user_idea_path(user, idea)

    assert current_path, edit_user_idea_path(user, idea)

    fill_in "Name", with: "Ski Lift App"
    fill_in "Description", with: "Reports lift line wait time"
    click_on "Update Idea"

    assert current_path, user_idea_path(user, idea)
    assert page.has_content?("Ski Lift App")
    refute page.has_content?("Golf App")
  end
end
