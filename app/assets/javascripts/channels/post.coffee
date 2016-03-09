App.comments = App.cable.subscriptions.create "CommentsChannel",
  collection: -> $("[data-channel='comments']")

  connected: ->
    setTimeout =>
      @followCurrentMessage()
      @installPageChangeCallback()
    , 1000

  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    @collection().append(data.comment) unless @userIsCurrentUser(data.comment)

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

  userIsCurrentUser: (comment) ->
    $(comment).attr('data-user-id') is $('meta[name=current-user]').attr('id')

$(document).on 'keypress', '[data-behavior~=post_comment]', (event) ->
  if event.keyCode is 13
    App.comments.comment({
      content: $('#comment_content').val(),
      post_id: $("[data-channel='comments']").data('post-id')
    })
    $('#comment_content').val('')
    event.preventDefault()
