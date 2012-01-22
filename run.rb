require 'cinch'
require 'sinatra'
require './plugins/imagesearch'
require './plugins/math'
require './plugins/chucknorris'
require './plugins/seen'
require './plugins/codeshortcuts'
require './plugins/listen_and_post'
require './constants'

Brandur = Cinch::Bot.new do
  configure do |c|
    c.server = SERVER
    c.channels = CHANNELS
    c.password = SERVER_PASSWORD or ''
    c.nick = NICK or 'brandur'
    c.plugins.plugins = [Plugins::ImageSearch, Plugins::Math, Plugins::ChuckNorris, Plugins::Seen, Plugins::CodeShortcuts,Plugins::ListenAndPost]
    c.plugins.prefix = "#{c.nick} "
  end
  
  on :join do |m|
    if m.user.nick == bot.nick # If I'm joining
      m.channel.send "I'm back guys."
    end
  end


    def self.say(msg)
      CHANNELS.each do |c|      
        Brandur.Channel(c).send msg
      end
    end



end

Thread.new do
  Brandur.start
end
