
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
     @post.updated_at = Time.now
    if @post.update(updated_params)
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

  def find_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title,:author,:image,:text,:user_id,tags_attributes:[:id,:name,:_destroy])
  end

  def updated_params
    updated_params = post_params
    middle_table = @post.posts_tags
    updated_params[:tags_attributes].each{ |key,value| 

      # 変更の際、削除されたもの以外は飛ばす
      next if value[:_destroy] != "1" || value[:id].nil?

      middle_id = middle_table.find_by(tag_id: value[:id]).id
      PostsTag.delete(middle_id)
      updated_params[:tags_attributes].delete(key)
    }
    
    return updated_params
  end

end
