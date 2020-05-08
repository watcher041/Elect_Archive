class Api::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    unless @comment.save
      render root_path
    end
  end

  private
  def comment_params
    params.permit(:name,:text,:respondent,:answer)
  end
end
