class TwitterController < ApplicationController
  def check
    response = Tweet.check_for_new_tweets
    render :text => response
  end
end
