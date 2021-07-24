class Users::BookmarksController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id])
    bookmark = Bookmark.new(diary_id: @diary.id, user_id: current_user.id)
    bookmark.save
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    bookmark = Bookmark.find_by(diary_id: @diary.id, user_id: current_user.id)
    bookmark.destroy
  end
end
