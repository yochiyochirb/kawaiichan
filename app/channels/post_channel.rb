# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PostChannel < ApplicationCable::Channel
  def subscribed
    @post_channel_id = SecureRandom.hex
    stream_from "post_channel_#{@post_channel_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def preview(data)
    PostPreviewJob.perform_later(channel_id: @post_channel_id,
                                 source: data["source"])
  end
end
