require 'nokogiri'
require 'cgi'
require 'open-uri'

module Plugins
  class Urban
    include Cinch::Plugin
    
    match /^(urban|what is(?: a(?:n)?)?|define) (.+)/i, use_prefix: false
    
    UrbanUrl = "http://www.urbandictionary.com/define.php?term=%s"
    
    Messages = [
      "What am I, an encyclopaedia?",
      "Are you talking to me?",
      "I don't know.",
      "I don't know that.",
      "Damn it Jimmy, I'm just a doctor!",
      "I don't know *everything*",
      "/me sighs",
    ]
    
    def execute m, command, query
      queryurl = UrbanUrl % CGI.escape(query)
      
      response = Nokogiri::HTML(open(queryurl.to_s)).at("div.definition").text.gsub(/\s+/, ' ') rescue nil
      
      if response
        m.reply "#{query}: #{response.to_s}"
      else
        m.reply Messages[rand(Messages.length)]
      end
      
    end
  end
end





