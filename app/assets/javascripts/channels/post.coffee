App.post = App.cable.subscriptions.create "PostChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

    # TODO: It's better to create this channel only on editor page
    if document.getElementById('post_title') != null
      @perform 'preview', source: {
        title: document.getElementById('post_title').value,
        body: document.getElementById('post_body').value
      }

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    document.getElementById('post-preview').innerHTML = data['preview_html']

  preview: (source) ->
    @perform 'preview', source: source
