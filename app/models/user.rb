class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def tweet_user
    $twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = self.token #ENV['Access_Token']
      config.access_token_secret = self.token_secret #ENV['Access_Token_Secret']
    end
     $twitter
  end

end
