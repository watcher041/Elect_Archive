class PostsController < ApplicationController

  before_action :find_post, only: [:edit,:update,:destroy]

  def index
    @answers = Answer.includes(:comment).order("updated_at DESC")
    @tags = Tag.includes(:posts)
  end

  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = '投稿が完了しました'
      redirect_to root_path
    else 
      render "new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy

    @post.destroy
    
    redirect_to root_path
  end

  private
  
  def post_params
    params.require(:post).permit(:title,:author,:image,:text,:user_id,tags_attributes:[:id,:name,:_destroy])
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
