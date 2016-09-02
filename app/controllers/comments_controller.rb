class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)

    if @comment.save
      redirect_to post, notice: "Comment has been successfully created."
    else
      redirect_to post, alert: "Hoge!"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body).merge(commented_by: current_user)
    end
end
