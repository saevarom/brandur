require 'cinch'
require './plugins/imagesearch'
require './plugins/math'
require './constants'

Brandur = Cinch::Bot.new do
  configure do |c|
    c.server = SERVER
    c.channels = CHANNELS
    c.password = SERVER_PASSWORD or ''
    c.nick = NICK or 'brandur'
    c.plugins.plugins = [Plugins::ImageSearch, Plugins::Math]
    c.plugins.prefix = "#{c.nick} "
  end
end

Brandur.start
