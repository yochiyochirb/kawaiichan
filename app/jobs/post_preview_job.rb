class PostPreviewJob < ApplicationJob
  queue_as :default

  def perform(user:, source:)
    ActionCable.server.broadcast "post_channel_#{user.id}",
                                 preview_html: render_preview(source)
  end

  private

  def render_preview(source)
    ApplicationController.renderer.render partial: 'posts/preview', locals: { title: source['title'], body: source['body'] }
  end
end
