class FollowsController < ApplicationController
  def create
    @user = User.find_by!(username: params[:user_id])
    Current.user.active_follows.find_or_create_by(followed: @user) unless @user == Current.user

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: user_path(@user) }
    end
  end

  def destroy
    @user = User.find_by!(username: params[:user_id])
    Current.user.active_follows.where(followed: @user).destroy_all

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: user_path(@user) }
    end
  end
end
