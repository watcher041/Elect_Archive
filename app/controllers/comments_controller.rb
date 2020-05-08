class CommentsController < ApplicationController

  def index
    @comments = Comment.where(answer_id:nil).order("created_at DESC")
  end
  
  def create
      comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'メッセージが送信されました'
      redirect_to root_path 
    else
      redirect_to root_path, alert: "ERROR! メッセージが送信できませんでした"
    end
    
  end

  private
  def comment_params
    params.permit(:name,:text)
  end
end
