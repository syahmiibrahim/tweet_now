class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def tweet_user
    $twitter = Twitter::REST::Client.new do |config|
      config.consumer_key =  API_KEY["TWITTER_CONSUMER_KEY"] #ENV['TWITTER_KEY']
      config.consumer_secret = API_KEY["TWITTER_CONSUMER_SECRET"] #ENV['TWITTER_SECRET']
      config.access_token = self.token #ENV['Access_Token']
      config.access_token_secret = self.token_secret #ENV['Access_Token_Secret']
    end
     $twitter
  end

  def update_tweet(status)
    tweet = self.tweets.create!(text: status)
    # byebug
    TweetWorker.perform_async(tweet.id)
  end
end
