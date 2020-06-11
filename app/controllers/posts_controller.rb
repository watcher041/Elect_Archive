
class PostsController < ApplicationController

  before_action :find_post, only: [:edit,:update,:destroy]

  def new
    @post = Post.new
  end

  def create

    # 投稿情報の保存
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
    update_params = @post.update_or_delete_tag(post_params)
    if @post.update(update_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    
    # 削除する前に、関連づいているタグを取得
    tags = @post.tags
    tags.each do |tag|
      PostsTag.find_by( post_id: params[:id] , tag_id: tag.id ).delete
      tag.delete if tag.posts.length == 0
    end

    # 中間テーブルまでの削除を行う
    if @post.delete
      redirect_to root_path, notice: "削除が完了しました"
    else
      redirect_to root_path, alert: "削除が失敗しました"
    end

  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title,:author,:image,:text,tags_attributes: [:name,:_destroy,:id] ).merge(user_id:current_user.id)
  end

end
