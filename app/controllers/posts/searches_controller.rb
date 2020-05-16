class Posts::SearchesController < ApplicationController
  def index
    result = Post.search(params[:keyword])

    # メソッドを使用して作成したデータは配列扱いになるため、kaminari独自のメソッドでpagenateさせる
    @posts = Kaminari.paginate_array(result).page(params[:page]).per(3)
  end
end
