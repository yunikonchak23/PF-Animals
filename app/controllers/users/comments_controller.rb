class Users::CommentsController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @comment = current_user.comments.new(comment_params)
    @comment.diary_id = @diary.id
    @comment.save
    redirect_to diary_path(@diary)
  end

  def destroy
    Comment.find_by(id: params[:id], diary_id: params[:diary_id]).destroy
    redirect_to diary_path(params[:diary_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
