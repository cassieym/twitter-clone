class UsersController < ApplicationController
  before_action :set_user

  def show
    @tweets = @user.tweets.includes(:user).recent
  end

  def edit
    redirect_to user_path(@user) unless @user == Current.user
  end

  def update
    if @user == Current.user && @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by!(username: params[:id])
  end

  def user_params
    params.expect(user: [ :display_name, :bio, :avatar ])
  end
end
