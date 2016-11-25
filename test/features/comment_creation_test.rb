require "test_helper"

feature "CommentCreation" do
  scenario "User create comment to post" do
    stub_authentication_with "alice"

    visit post_path(post)

    body = "Lorem ipsum dolor sit amet"

    fill_in "comment_body", with: body
    click_button "create comment"

    within ".comment__body" do
      expect(page).must_have_content "Lorem ipsum dolor sit amet"
    end
  end
end
