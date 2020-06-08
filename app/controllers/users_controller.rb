
class UsersController < ApplicationController

  def index

    # コメント一覧の取得
    @comments = Comment.includes(:user)

    # タグに関連づく書籍を取得
    @posts = Post.includes(:tags)
    @tags = Tag.where(ancestry:nil).order(name: :ASC)
    
  end


# def new
  
# end

# def create
#     @answer = Answer.new(answer_params)
#   if @answer.save
#     comment = Comment.find(params[:comment_id])
#     if comment.update(answer_id: @answer.id)
#       flash[:notice] = 'メッセージが送信されました'
#     end
#       redirect_to root_path
#   else
#     render "new" 
#   end
# end


    def show
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page]).per(3).order("created_at DESC")
    end

end