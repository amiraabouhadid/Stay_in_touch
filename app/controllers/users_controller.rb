class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friends = current_user.friends.filter { |f| f != current_user }
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = current_user.friends.filter { |f| f if f != current_user }
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end
end
