require "test_helper"

class UserCanCreateAnIdeaTest < ActionDispatch::IntegrationTest
  def test_user_can_create_an_idea
    user = User.create(username: "matthew", password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit new_user_idea_path(user)

    fill_in "Name", with: "Golf App"
    fill_in "Description", with: "App finds next available tee time based on location"

    click_on "Create Idea"

    assert_equal current_path, user_idea_path(user, Idea.last)

    assert page.has_content?("Golf App")
    # assert page.has_content?("available")

  end
end
