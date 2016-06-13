require 'test_helper'

feature 'PostCreation' do
  scenario 'User create post', js: true do
    stub_authentication_with 'alice'

    visit new_post_path

    title = 'Through the Looking-Glass, and What Alice Found There'
    body = 'One thing was certain, that the white kitten had nothing.'

    fill_in 'post_title', with: title
    fill_in 'post_body', with: body

    click_button 'Save'

    within '.flash-message__notice' do
      page.must_have_content 'Post was successfully created.'
    end

    within '.post__title' do
      page.must_have_content title
    end

    within '.post__body' do
      page.must_have_content body
    end

    post = Post.last
    post.user.must_equal User.find_by!(nickname: 'alice')
    post.title.must_equal title
    post.body.must_equal body
  end
end
