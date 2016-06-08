# Provides kawaiichan specific Slack authentication methods
concern :Authenticator do
  class_methods do
    def team_member?(uid)
      team_member_uids = fetch_team_member_uids
      uid.in?(team_member_uids)
    end

    def fetch_team_member_uids
      users_list = Slack::Web::Client.new.users_list
      users_list.members.map(&:id)
    end
  end
end
