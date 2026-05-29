class RepliesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Current.user.tweets.build(body: reply_params[:body], parent: @tweet)

    if @reply.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to tweet_path(@tweet) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("reply-form", partial: "tweets/reply_form", locals: { tweet: @tweet, reply: @reply }) }
        format.html { redirect_to tweet_path(@tweet) }
      end
    end
  end

  private

  def reply_params
    params.expect(tweet: [ :body ])
  end
end
