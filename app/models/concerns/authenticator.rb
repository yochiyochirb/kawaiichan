# Provides kawaiichan specific Slack authentication methods
concern :Authenticator do
  class_methods do
    def team_member?(uid)
      member_uids = fetch_member_uids
      uid.in?(member_uids)
    end

    def fetch_member_uids
      users_list = Slack::Web::Client.new.users_list
      users_list.members.reject(&:deleted).map(&:id)
    end
  end
end
