App.comments = App.cable.subscriptions.create "CommentsChannel",
  collection: -> $("[data-channel='comments']")

  connected: ->
    @followCurrentMessage()
    @installPageChangeCallback()

  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    @collection().append(data.comment)

  followCurrentMessage: ->
    if post_id = @collection().data('post-id')
      @perform 'follow', post_id: post_id
    else
      @perform 'unfollow'

  comment: (message) ->
    @perform 'comment', message: message

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.comments.followCurrentMessage()

$(document).on 'keypress', '[data-behavior~=post_comment]', (event) ->
  if event.keyCode is 13
    App.comments.comment({
      content: $('#comment_content').val(),
      post_id: $("[data-channel='comments']").data('post-id')
    })
    $('#comment_content').val('')
    event.preventDefault()
