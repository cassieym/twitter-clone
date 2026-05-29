class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :show, :destroy ]

  def show
    @ancestors = @tweet.ancestors
    @replies = @tweet.replies.includes(:user).order(:created_at)
    @reply = Tweet.new(parent: @tweet)
  end

  def create
    @tweet = Current.user.tweets.build(tweet_params)
    if @tweet.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("tweet-compose-form", partial: "tweets/form", locals: { tweet: @tweet }) }
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    @tweet.destroy if @tweet.user == Current.user
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("tweet-#{@tweet.id}") }
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.expect(tweet: [ :body, :parent_id ])
  end
end
