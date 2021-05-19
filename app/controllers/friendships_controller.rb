class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id], confirmed: false)
    if @friendship.save
      redirect_to users_path, notice: 'Request sent'
    else
      redirect_to users_path, notice: 'Something went wrong. Request not sent. Try again.'
    end
  end

  def index
    @users = User.all
    @friends = current_user.friends.filter { |f| f != current_user }
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendship = current_user.inverse_friendships.find { |f| f.user == @user }
    @friendship.destroy
    redirect_to users_path, notice: 'friendship deleted'
  end

  def accept
    @user = User.find(params[:user_id])
    @friendship = current_user.inverse_friendships.find { |f| f.user == @user }
    @friendship.confirmed = true
    @friendship.save
    Friendship.create!(friend_id: @user.id, user_id: current_user.id, confirmed: true)
    redirect_to users_path(params[:id]), notice: 'You are now friends!'
  end
end
