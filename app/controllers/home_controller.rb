class HomeController < ApplicationController
  def index
    @tweet = Tweet.new
    @tweets = Current.user.feed_tweets.includes(:user, :likes).limit(50)
  end
end
