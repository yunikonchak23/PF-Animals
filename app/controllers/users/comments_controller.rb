class Users::CommentsController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @comment = current_user.comments.new(comment_params)
    @comment.diary_id = @diary.id
    @comment.save
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
