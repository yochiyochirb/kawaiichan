require "test_helper"

feature "Login with slack" do
  scenario "Must have login link" do
    visit login_path

    within ".login__login-link" do
      expect(page).must_have_content "Login with Slack"
    end
  end

  scenario "Team member can login with Slack" do
    stub_slack_login_with "alice"

    visit login_path

    VCR.use_cassette "slack/users_info" do
      click_link "Login with Slack"
    end

    within ".flash-message__notice" do
      expect(page).must_have_content "Logged in with Slack"
    end

    within ".navigation__list" do
      expect(page).must_have_content "Logout"
    end
  end

  scenario "User who is not in team cannot login with Slack" do
    # Create non-team member user for testing
    User.create(nickname: "dodo", provider: "slack", uid: "NOTINTEAM")

    stub_slack_login_with "dodo"

    visit login_path

    VCR.use_cassette "slack/users_info" do
      click_link "Login with Slack"
    end

    within ".flash-message__alert" do
      expect(page).must_have_content "Only team member can login"
    end
  end
end
