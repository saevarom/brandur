require 'nokogiri'
require 'cgi'
require 'open-uri'

module Plugins
  class Foos
    include Cinch::Plugin
    
    match /(foos stat(:?s))/i, use_prefix: false
    match /(efstur|bestur|best|top)/i, use_prefix: false, method: :top
    
    FoosUrl = "http://www.maggi.is/transmit/json.php"
    
    def execute m, command
      call = Curl::Easy.perform(FoosUrl)
      json = JSON.parse call.body_str
      json.each do |rank|
        m.reply "#{rank[1]['rank']}. #{rank[1]['name']} #{rank[1]['win']}/#{rank[1]['lose']} #{rank[1]['hlutfall']} #{rank[1]['goalscore']} #{rank[1]['avg']}"
      end
    end

    def top m, command
      call = Curl::Easy.perform(FoosUrl)
      json = JSON.parse call.body_str
      m.reply "#{json.first[1]['name']}"
    end

  end
end

