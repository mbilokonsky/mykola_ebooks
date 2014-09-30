#!/usr/bin/env ruby

require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define as many of these as you like; they will run simultaneously

Ebooks::Bot.new("mykola_ebooks") do |bot|
  # Consumer details come from registering an app at https://dev.twitter.com/
  # OAuth details can be fetched with https://github.com/marcel/twurl
  bot.consumer_key = "D43RusoTf1sMum279UIxjBB3Q" # Your app consumer key
  bot.consumer_secret = "refDx27gGtUBS0AutAFfn3GzcWL6Nx7i3B8n2gUcNv5WUFjUQd" # Your app consumer secret
  bot.oauth_token = "2793031960-gxsE8K1HLUb9wvvooHj4I0UkCG9MwSzW37YKdkN" # Token connecting the app to this account
  bot.oauth_token_secret = "ya1vWOWo7AIGkp1yDoIzXYgNk7KfdWUNiIjf3OuGfsxv4" # Secret connecting the app to this account

  bot.on_message do |dm|
    # Reply to a DM
    bot.reply(dm, "secret secrets")
  end

  bot.on_follow do |user|
    # Follow a user back
    bot.follow(user[:screen_name])
  end

  bot.on_mention do |tweet, meta|
    # Reply to a mention
    model = Ebooks::Model.load("model/mykola.model");
    bot.reply(tweet, meta[:reply_prefix] + model.make_statement(125))
  end

  bot.on_timeline do |tweet, meta|
    # Reply to a tweet in the bot's timeline
    # bot.reply(tweet, meta[:reply_prefix] + "nice tweet")
  end

  bot.scheduler.every '6h' do
    # Tweet something every 24 hours
    # See https://github.com/jmettraux/rufus-scheduler
    model = Ebooks::Model.load("model/mykola.model");
    bot.tweet(model.make_statement(140));
  end
end
