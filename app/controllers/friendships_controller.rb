class FriendshipsController < ApplicationController
  def create
    @user = current_user
    @friend = User.find(params[:user_id])
    @user.send_request(@friend)
    redirect_to user_path(@friend)
  end

  def destroy; end

  def confirm
    @user = current_user
    @friend = User.find(params[:user_id])
    @user.confirm_friend(@friend)
    redirect_to user_path(@user)
  end

  def decline
    @user = current_user
    @friend = User.find(params[:user_id])
    @user.decline_friend(@friend)
    redirect_to user_path(@user)
  end
end
