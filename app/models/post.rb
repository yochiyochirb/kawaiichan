class Post < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  validates :title, presence: true

  has_paper_trail

  before_validation :copy_created_by_id_to_updated_by_id, on: :create

  private

  def copy_created_by_id_to_updated_by_id
    self.updated_by_id = created_by_id
  end

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
        channel: ENV['SLACK_POST_CHANNEL'],
        text: "#{self.created_by.nickname} #{action}d *#{self.title}*.",
        attachments: attachment(self),
        as_user: false,
        username: 'kawaiichan',
        icon_emoji: ':new_moon_with_face:'
      }
    end

    def client
      @client ||= Slack::Web::Client.new
    end

    def attachment(post)
      JSON.generate([
        {
          title: post.title,
          title_link: "#{Rails.configuration.kawaiichan_url}/posts/#{post.id}",
          text: post.body,
          mrkdwn_in: ['text']
        }
      ])
    end
  end
end
