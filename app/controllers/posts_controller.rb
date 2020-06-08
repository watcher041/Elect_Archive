
class PostsController < ApplicationController

  before_action :find_post, only: [:edit,:update,:destroy]

  def new
    @post = Post.new
  end

  def create

    # タグの親を探索し、タグをその子供として保存
    tag_ids = []
    params[:post][:tags_attributes].each do |key,tag|
      word = Zipang.to_slug tag[:name]
      parent = Tag.find_by( ancestry: nil , name: word[0].upcase )
      child = parent.children.find_or_create_by( name:tag[:name])
      tag_ids << child.id
    end

    # tag_idsで中間テーブルにidの関連情報を保存
    middle_post_params = post_params
    middle_post_params[:tag_ids] = tag_ids
    
    # 投稿情報の保存
    @post = Post.new(middle_post_params)
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
    params.require(:post).permit(:title,:author,:image,:text,tag_ids: []).merge(user_id:current_user.id)
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
