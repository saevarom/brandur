require 'cinch'
require 'cgi'

module Plugins
  class ChuckNorris
    include Cinch::Plugin
    
    JokeUrl = "http://api.icndb.com/jokes/random"

    timer 45*60, method: :timed
    def timed
      call = Curl::Easy.perform(JokeUrl)
      json = JSON.parse call.body_str
      if json["type"] == "success"
        @bot.config.channels.each do |channel|
          Channel(channel).send "#{CGI.unescapeHTML(json['value']['joke'].to_s)}"
        end
      end
    end
  end
end
