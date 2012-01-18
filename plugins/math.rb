require 'cinch'
require 'curb'
require 'cgi'
require 'json'


module Plugins
  class Math
    include Cinch::Plugin
    
    CalcUrl = "http://www.google.com/ig/calculator?hl=en&q=%s"
    
    match /(calc|calculate|convert|math|reikna\303\260u) (.*)/iu
    
    def execute m, command, query
      
      query = CalcUrl % CGI.escape(query)
      
      call = Curl::Easy.perform(query) do |curl|
        curl.headers["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"
        curl.headers["Accept-Language"] = "en-us,en;q=0.5"
        curl.headers["Accept-Charset"] = "utf-8"
      end
      # Non-string json keys can't be parsed using JSON
      # Must eval it
      json = eval(call.body_str).reduce({}) {|h,(k,v)| h[k.to_s] = v; h}

      if !json["lhs"].empty? and !json["rhs"].empty?
        m.reply "#{json['lhs']} equals #{json['rhs']}"
      else
        m.reply "Sorry, could not compute."
      end
    end
  end
end

