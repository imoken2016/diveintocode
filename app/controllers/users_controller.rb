class UsersController < ApplicationController
  def index
    #@users = User.all
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

   def followers
     @user = User.find(:params[:id])
     @users = @user.followers.paginate(page: params[:page])
     render 'show_follow'
   end

end

