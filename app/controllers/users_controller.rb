class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friend_requests = current_user.friend_requests
    @current_user_friends = current_user.friends.filter { |f| f if f != current_user and !@friend_requests.include?(f) and f != @user }.uniq
    @pending_friends = current_user.pending_friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_requests = current_user.friend_requests
    @current_user_friends = current_user.friends.filter { |f| f if f != current_user and !@friend_requests.include?(f) and f != @user }.uniq
    @pending_friends = current_user.pending_friends
    @user_friends_count = @user.friends.uniq.count
  end
end
