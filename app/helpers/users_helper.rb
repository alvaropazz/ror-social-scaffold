module UsersHelper
  def friendship_action
    if current_user != @user
      friend_request_button
    elsif current_user
      content_tag(:div, class: 'friendship-box') do
        concat(content_tag(:div, class: 'pending-requests') do
          concat(content_tag(:strong) do
            'Pending Friend Requests:'
          end)
          concat(tag(:br))
          concat(tag(:br))
          @friend_requests.each do |f|
            concat(content_tag(:strong) do
              link_to f.name.capitalize, user_path(f), class: 'friend-link'
            end)
          end
        end)
        concat(content_tag(:div, class: 'all-friends') do
          concat(content_tag(:strong) do
            'All Friends:'
          end)
          concat(tag(:br))
          concat(tag(:br))
          concat(content_tag(:ul) do
            @friends.each do |f|
              concat(content_tag(:li) do
                link_to f.name, user_path(f)
              end)
            end
          end)
        end)
      end
    end
  end

  def friend_request_button
    if current_user.friend?(@user)
      button_to "You're already friends!", {}, { disabled: true }
    elsif current_user.pending_friends.include?(@user)
      content_tag(:p) do
        button_to 'Your request is pending!', {}, { disabled: true }
      end
    elsif current_user.friend_requests.include?(@user)
      content_tag(:div, class: 'friend-request') do
        concat(button_to('Confirm Request', confirm_user_friendship_path(id: current_user, user_id: @user)))
        concat(button_to('Decline Request', decline_user_friendship_path(id: current_user, user_id: @user)))
      end
    else
      button_to 'Send Request', user_friendships_path(@user)
    end
  end

  def index_users
    @users.map do |user|
      @user = user
      content_tag(:li) do
        concat(content_tag(:strong) do
          "Name: #{user.name}"
        end)
        concat(content_tag(:span, class: 'profile-link') do
          if current_user == @user
            concat(link_to('See your Profile', user_path(user), class: 'profile-link'))
          else
            concat(link_to('See Profile', user_path(user), class: 'profile-link'))
          end
        end)
        if current_user != @user
          concat(content_tag(:span, class: 'profile-link') do
            concat(friend_request_button)
          end)
        end
      end
    end.join.html_safe
  end
end
