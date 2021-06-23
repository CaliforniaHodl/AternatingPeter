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

    # get last tweet from peter
    tweet = client.user_timeline('PeterSchiff', count: 1)

    @lastTwitterId = Tweet.last.twitterId

    p @lastTwitterId

    tweet.each do |tweet|
        if @lastTwitterId != tweet.id

          body = tweet.full_text

          t = Tweet.new
          t.content = body
          t.twitterId = tweet.id
          t.save
        end

    end


    # blank string for transformation
    newText = ''
    body.chars.map.with_index { |ch, idx|
      newText += idx.even? ? ch.upcase : ch.downcase
    }

    # print results
    p newText

    client.update(newText)

    puts "It works!"
  end

end
