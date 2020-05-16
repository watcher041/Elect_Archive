class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts =  Kaminari.paginate_array（@user.post.page(params[:page]).per(3).order("created_at DESC")
  end
end
