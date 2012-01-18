require 'cinch'
require 'curb'
require 'uri'
require 'json'


module Plugins
  class ImageSearch
    include Cinch::Plugin
    
    ImageUrl = "ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&q=%s"
    
    match /(image|img) (.*)/i
    
    def execute m, user, query
      
      query = ImageUrl % URI.escape(query)
      
      call = Curl::Easy.perform(query)
      json = JSON.parse call.body_str
      results = json['responseData']['results']
      if results.length > 0
        selected = results[rand(results.length)]
        m.reply "#{selected['unescapedUrl']}"
      else
        m.reply "Couldn't find anything :("
      end
    end
  end
end


