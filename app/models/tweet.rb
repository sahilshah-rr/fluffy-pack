class Tweet < ActiveRecord::Base

  def self.check_for_new_tweets
    response            = "NO"
    last_tweet          = self.first || self.create!(:tweet_id => "144138727650889728", :last_check_at => 1.day.ago)
    tweets              = JSON.parse(
      Tweet.access_token.request(
        :get,
        "https://api.twitter.com/1/statuses/mentions.json?trim_user=t"
      ).body
    )
    new_last_check_time = Time.now.utc
    new_max_tweet_id    = tweets.map { |tweet| tweet["id_str"].to_i }.max.to_i
    if tweets.select { |tweet|
      tweet["id_str"].to_i > last_tweet.tweet_id.to_i
    }.any? { |tweet|
      tweet["text"].match(/^.*(love|<3).*$/im).present?
    }
      response = "YO"
    end
    last_tweet.update_attributes(:tweet_id => new_max_tweet_id, :last_check_at => new_last_check_time)
    response
  end

  # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
  def self.access_token
    consumer   = OAuth::Consumer.new(
      'bjaFODA0kjxhYlpeWi7IsA',
      'fqUEnGxsJoGGmp5qmzaw9VSPxcPF31EVwwNUMDk3pc',
      {
        :site   => "http://api.twitter.com",
        :scheme => :header,
      }
    )
    # now create the access token object from passed values
    token_hash = {
      :oauth_token        => '190461027-GUbIxGr2tgXPk1TgmJ80dWUWtlKqMdNZaiYFPbBl',
      :oauth_token_secret => 'QDRDL2RoWs1GSF8Q9O9lu5VHD27872vahlR1OEA',
    }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end
end



