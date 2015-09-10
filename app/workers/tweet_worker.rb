class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user = tweet.user 

    puts "Working--------->"

    twitter = TweetWorker.access(user.token, user.token_secret)
    twitter.update(tweet.text)

    puts "Done------------>#{tweet.text}"
  end

  private

  def self.access(token1, token_secret1)
    Twitter::REST::Client.new do |config|
      config.consumer_key         = API_KEY["TWITTER_CONSUMER_KEY"]
      config.consumer_secret      = API_KEY["TWITTER_CONSUMER_SECRET"]
      config.access_token         = token1
      config.access_token_secret  = token_secret1
  end
end


def self.job_is_complete(jid)
  waiting = Sidekiq::Queue.new
  working = Sidekiq::Workers.new
  pending = Sidekiq::ScheduledSet.new
  return false if pending.find { |job| job.jid == jid }
  return false if waiting.find { |job| job.jid == jid }
  return false if working.find { |process_id, thread_id, work| work["payload"]["jid"] == jid }
  true
end
end