class FriendshipsController < ApplicationController
  def create
    friend_id = params[:user][:invitee_id]
    row1 = { user_id: current_user.id, friend_id: friend_id, initiator_id: current_user.id, confirmed: nil }
    row2 = { user_id: friend_id, friend_id: current_user.id, initiator_id: current_user.id, confirmed: nil }
    begin
      ActiveRecord::Base.transaction do
        Friendship.create!(row1)
        Friendship.create!(row2)
      end
      redirect_to users_path, notice: 'Request sent'
    rescue ActiveRecord::Rollback
      redirect_to users_path, alert: 'Something went wrong, try again later'
    end
  end
end
