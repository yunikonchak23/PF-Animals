class SearchController < ApplicationController
  def search
    @user = current_user
    @diary_new = Diary.all.order(" created_at DESC ")
    @model = params[:model]
		@content = params[:content]
		if @model == 'user'
			@records = User.where('name LIKE ?', '%'+@content+'%')
		elsif @model == 'pet'
			@records = Pet.where(['pet_name LIKE ? OR type_name LIKE ?', '%'+@content+'%', '%'+@content+'%'])
		elsif @model == 'question'
		  @records = Question.where(['question_title LIKE ? OR question_body LIKE ?', '%'+@content+'%', '%'+@content+'%'])
		else
			render
		end
  end
end
