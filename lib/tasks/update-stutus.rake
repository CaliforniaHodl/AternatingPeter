namespace :ap do
  desc "get the last updated stat, and sent it to twitter"
  task :update_status => :environment do

    # request string
    body =  ""

    #get Twitter credential
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET_KEY']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    twitterId = 0
    tweetid = client.user_timeline('PeterSchiff', count: 1)

    tweetid.each do |tweet|
      twitterId =  tweet.id
    end

    tweet = client.status(twitterId , tweet_mode: 'extended').text
    bodyNotLink = tweet.split(' https:')[0]

    # # blank string for transformation
    newText = ''
    bodyNotLink.chars.map.with_index { |ch, idx|
      newText += idx.even? ? ch.upcase : ch.downcase
    }

    # print results
    p newText

    # client.update(newText)

    puts "It works!"
  end

end
