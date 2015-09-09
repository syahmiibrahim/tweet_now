class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def tweet_user
    $twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = API_KEY["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = API_KEY["TWITTER_CONSUMER_SECRET"]
      config.access_token = self.token
      config.access_token_secret = self.token_secret
    end
     $twitter
  end

end
