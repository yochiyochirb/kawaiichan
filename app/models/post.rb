class Post < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  validates :title, presence: true

  concerning :Notifiable do
    included do
      after_create_commit :notify_to_create
      after_update_commit :notify_to_update
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
        as_user: true
      }
    end

    def client
      @client ||= Slack::Web::Client.new
    end

    def attachment(post)
      domain = ENV['KAWAIICHAN_URL'] || 'http://localhost:3000'

      JSON.generate([
        {
          title: post.title,
          title_link: "#{domain}/posts/#{post.id}",
          text: post.body,
          mrkdwn_in: ['text']
        }
      ])
    end
  end
end
