class LikesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    Current.user.likes.find_or_create_by(tweet: @tweet)
    @tweet.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    Current.user.likes.where(tweet: @tweet).destroy_all
    @tweet.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end
end
