class Post < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  has_paper_trail

  concerning :Notifiable do
    included do
      after_create_commit :notify_to_create if slack_notification_enabled?
      after_update_commit :notify_to_update if slack_notification_enabled?
    end

    class_methods do
      def slack_notification_enabled?
        Rails.configuration.slack_notification_enabled
      end
    end

    private

    def notify_to_create
      client.chat_postMessage(post_params_of(:create))
    end

    def notify_to_update
      client.chat_postMessage(post_params_of(:update))
    end

    def post_params_of(action)
      {
        channel: ENV["SLACK_POST_CHANNEL"],
        text: "#{created_by.nickname} #{action}d *#{title}*.",
        attachments: attachment,
        as_user: false,
        username: "kawaiichan",
        icon_emoji: ":new_moon_with_face:"
      }
    end

    def client
      @client ||= Slack::Web::Client.new
    end

    def attachment
      JSON.generate(
        [
          {
            title: title,
            title_link: "#{Rails.configuration.kawaiichan_url}/posts/#{id}",
            text: body,
            mrkdwn_in: ["text"]
          }
        ]
      )
    end
  end
end
