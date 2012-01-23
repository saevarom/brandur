require 'cinch'
require './plugins/imagesearch'
require './plugins/math'
require './plugins/chucknorris'
require './plugins/twss'
require './plugins/seen'
require './plugins/sensitive'
require './plugins/urban'
require './plugins/foos'
require './plugins/polite'
require './constants'

Brandur = Cinch::Bot.new do
  configure do |c|
    c.server = SERVER
    c.channels = CHANNELS
    c.password = SERVER_PASSWORD or ''
    c.nick = NICK or 'brandur'
    c.plugins.plugins = [
      Plugins::ImageSearch, 
      Plugins::Math, 
      Plugins::ChuckNorris, 
      Plugins::Seen, 
      Plugins::TWSS,
      Plugins::Sensitive,
      Plugins::Urban,
      Plugins::Foos,
      Plugins::Polite,
    ]
    c.plugins.prefix = "brandur "
  end
  
  on :join do |m|
    if m.user.nick == bot.nick # If I'm joining
      m.channel.send "I'm back guys."
    end
  end
  
end

Brandur.start
