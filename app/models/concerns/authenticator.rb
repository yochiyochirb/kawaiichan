# Provides kawaiichan specific Slack authentication methods
concern :Authenticator do
  class_methods do
    def team_member?(uid)
      member_uids = fetch_member_uids
      uid.in?(member_uids)
    end

    def fetch_member_uids
      team_info = Slack::Web::Client.new.team_info
      users_list = Slack::Web::Client.new.users_list
      users_list.members.reject(&:deleted).map(&:id).map do |uid|
        "#{uid}-#{team_info.team.id}"
      end
    end
  end
end
