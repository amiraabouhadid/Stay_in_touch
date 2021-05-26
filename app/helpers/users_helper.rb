module UsersHelper
  def include_invite_link?(user1, user2)
    !(user1.id == user2.id || user1.friends.include?(user2))
  end

  def pending_friend_request?(user)
    user.friend_requests.size.positive?
  end

  def user_profile(user)
    return unless user.id == current_user.id

    render 'profile', friend_requests: user.friend_requests, friends: user.confirmed_friends
  end

  def render_friend_requests(friends)
    return render 'empty_list', text: "you haven't received friendship requests yet; start adding friends!" if friends.empty?

    safe_join(friends.map { |friend| render 'friend_request', friend: friend })
  end

  def render_friends(friends)
    return render 'empty_list', text: "you don't have any friends yet; start adding friends/accepting requests!" if friends.empty?

    safe_join(friends.map { |friend| render 'friend', friend: friend })
  end

  def render_invite_link(user1, user2, class_name = nil)
    return nil unless include_invite_link?(user1, user2)

    render 'add_friend', user: user2, current_user: user1, class_name: class_name
  end
end
