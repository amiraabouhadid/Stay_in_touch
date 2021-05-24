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

  def friends
    friends_array = friendships.map { |f| f.friend if f.confirmed } + inverse_friendships.map { |f| f.user if f.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |f| f.friend unless f.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |f| f.user unless f.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
