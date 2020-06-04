module UsersHelper
  def friendship_action
    if current_user != @user
      if current_user.friend?(@user)
        "You're already friends!"
      elsif current_user.pending_friends.include?(@user)
        content_tag(:p) do
          'Your request is pending!'
        end
      else
        button_to 'Send Request', user_friendships_path(@user)
      end
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
              f.name.capitalize
            end)
            concat(content_tag(:div, class: 'friend-request') do
              concat(button_to('Confirm Request', confirm_user_friendship_path(f)))
              concat(button_to('Decline Request', decline_user_friendship_path(f)))
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
end
