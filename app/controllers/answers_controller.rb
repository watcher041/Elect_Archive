
class AnswersController < ApplicationController

  before_action :find_comment

  def new
  end

  def create
    if @comment.update(comment_params)
      flash[:notice] = 'メッセージが送信されました'
      redirect_to root_path
    else
      render "new" 
    end
  end

  private
  def find_comment
    @comment = Comment.find(params[:comment_id])
  end
  def comment_params
    params.permit(:answer).merge(user_id:current_user.id)
  end

end
