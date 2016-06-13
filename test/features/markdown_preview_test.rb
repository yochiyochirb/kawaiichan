require 'test_helper'

feature 'MarkdownPreview' do
  scenario 'User enters title', js: true do
    stub_authentication_with 'alice'

    visit new_post_path

    title = 'Through the Looking-Glass, and What Alice Found There'

    fill_in 'post_title', with: title

    within '#post-preview' do
      page.must_have_content title
    end
  end

  scenario 'User enters body', js: true do
    stub_authentication_with 'alice'

    visit new_post_path

    body = 'One thing was certain, that the white kitten had nothing.'

    fill_in 'post_body', with: body

    within '#post-preview' do
      page.must_have_content body
    end
  end

  scenario 'User enters both title and body', js: true do
    stub_authentication_with 'alice'

    visit new_post_path

    title = 'Through the Looking-Glass, and What Alice Found There'
    body = 'One thing was certain, that the white kitten had nothing.'

    fill_in 'post_title', with: title
    fill_in 'post_body', with: body

    within '#post-preview' do
      page.must_have_content title
      page.must_have_content body
    end
  end
end
