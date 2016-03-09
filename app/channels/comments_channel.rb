class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "posts:#{data['post_id']}:comments"
  end

  def unfollow
    stop_all_streams
  end

  def comment(data)
    Comment.create data['message'].merge(user: current_user)
  end
end
