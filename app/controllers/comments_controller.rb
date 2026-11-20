class CommentsController < ApplicationController

  def create
    @bug = Bug.find(params[:bug_id])
    @comment = @bug.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @bug, notice: 'Comment added.'
    else
      redirect_to @bug, alert: 'Could not save comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end