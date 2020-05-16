class Posts::SearchesController < ApplicationController
  def index
    result = Post.search(params[:keyword])
    @posts = Kaminari.paginate_array(result).page(params[:page]).per(3)
  end
end
