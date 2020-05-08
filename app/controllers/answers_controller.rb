
class AnswersController < ApplicationController

  def new
    @comment = Comment.find(params[:comment_id])
    @answer = Answer.new
  end

  def create
      @answer = Answer.new(answer_params)
    if @answer.save
      comment = Comment.find(params[:comment_id])
      if comment.update(answer_id: @answer.id)
        flash[:notice] = 'メッセージが送信されました'
      end
        redirect_to root_path
    else
      render "new" 
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:name,:text,:comment_id)
  end
end
