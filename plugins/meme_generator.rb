# Integrates with memegenerator.net
# Y U NO <text>              - Generates the Y U NO GUY with the bottom caption of <text>
# I don't always <something> but when i do <text> - Generates The Most Interesting man in the World
# <text> ORLY?               - Generates the ORLY? owl with the top caption of <text>
# <text> (SUCCESS|NAILED IT) - Generates success kid with the top caption of <text>
# <text> ALL the <things>    - Generates ALL THE THINGS
# <text> TOO DAMN <high> - Generates THE RENT IS TOO DAMN HIGH guy
# Good news everyone! <news> - Generates Professor Farnsworth
# khanify <text> - TEEEEEEEEEEEEEEEEEXT!
# Not sure if <text> or <text> - Generates Futurama Fry
# Yo dawg <text> so <text> - Generates Yo Dawg
require 'cgi'
require 'open-uri'
require 'json'

module Plugins
  class MemeGenerator
    include Cinch::Plugin

    match /(I DON'?T ALWAYS .*) (BUT WHEN I DO,? .*)/i, use_prefix: false, method: :i_dont_always
    match /(GOOD NEWS EVERYONE[,.!]?) (.*)/i,           use_prefix: false, method: :good_news
    match /(Y U NO) (.+)/,              use_prefix: false, method: :y_u_no
    match /(.*)(O\s?RLY\??.*)/i,        use_prefix: false, method: :orly
    match /(.*)(SUCCESS|NAILED IT.*)/i, use_prefix: false, method: :nailed_it
    match /(.*) (ALL the .*)/i,         use_prefix: false, method: :x_all_the_y
    match /(.*) (\w+\sTOO DAMN .*)/i,   use_prefix: false, method: :too_damn
    match /khanify (.*)/i,              use_prefix: false, method: :khanify
    match /(NOT SURE IF .*) (OR .*)/i,  use_prefix: false, method: :not_sure
    match /(YO DAWG .*) (SO .*)/i,      use_prefix: false, method: :yo_dawg
    #use_prefix: false, method: :x_all_the_y

    match /(dev) (I DON'?T ALWAYS .*) (BUT WHEN I DO,? .*)/i, use_prefix: false, method: :i_dont_always_dev
    match /(dev) (GOOD NEWS EVERYONE[,.!]?) (.*)/i,           use_prefix: false, method: :good_news_dev
    match /(dev) (Y U NO) (.+)/,              use_prefix: false, method: :y_u_no_dev
    match /(dev) (.*)(O\s?RLY\??.*)/i,        use_prefix: false, method: :orly_dev
    match /(dev) (.*)(SUCCESS|NAILED IT.*)/i, use_prefix: false, method: :nailed_it_dev
    match /(dev) (.*) (ALL the .*)/i,         use_prefix: false, method: :x_all_the_y_dev
    match /(dev) (.*) (\w+\sTOO DAMN .*)/i,   use_prefix: false, method: :too_damn_dev
    match /(dev) khanify (.*)/i,              use_prefix: false, method: :khanify_dev
    match /(dev) (NOT SURE IF .*) (OR .*)/i,  use_prefix: false, method: :not_sure_dev
    match /(dev) (YO DAWG .*) (SO .*)/i,            use_prefix: false, method: :yo_dawg_dev

    def yo_dawg_dev m, dev, q1, q2
      yo_dawg m, q1, q2, true
    end

    def yo_dawg m, q1, q2, dev=false
      meme = genMeme 79, 108785, q1, q2
      send_meme(m,meme,dev)
    end

    def not_sure_dev m, dev, q1, q2
      not_sure m, q1, q2, true
    end

    def not_sure m, q1, q2, dev=false
      meme = genMeme 305, 84688, q1, q2
      send_meme(m,meme,dev)
    end

    def khanify_dev m, dev, q1
      khanify m, q1, true
    end

    def khanify m, q1, dev=false 
      meme = genMeme 6443, 1123022, q1
      send_meme(m,meme,dev)
    end

    def good_news_dev m, dev, q1, q2
      good_news m, q1, q2, true
    end

    def good_news m, q1, q2, dev=false
      meme = genMeme 1591, 112464, q1, q2
      send_meme(m,meme,dev)
    end

    def too_damn_dev m, dev, q1, q2
      too_damn m, q1, q2, true
    end

    def too_damn m, q1, q2, dev=false
      meme = genMeme 998, 203665, q1, q2
      send_meme(m,meme,dev)
    end

    def x_all_the_y_dev m, dev, q1, q2
      x_all_the_y m, q1, q2, true
    end

    def x_all_the_y m, q1, q2, dev=false
      meme = genMeme 6013, 1121885, q1, q2
      send_meme(m,meme,dev)
    end

    def nailed_it_dev m, dev, q1, q2
      nailed_it(m,q1,q2,true)
    end

    def nailed_it m , q1, q2, dev=false
      meme = genMeme 121, 1031, q1, q2
      send_meme(m,meme,dev)
    end

    def orly_dev m, dev, q1, q2
      orly(m,q1,q2,true)
    end

    def orly m, q1,q2, dev=false
      meme = genMeme 920, 117049, q1, q2
      send_meme(m,meme,dev)
    end

    def i_dont_always_dev m, dev, q1, q2 
      i_dont_always(m,q1,q2,true)
    end

    def i_dont_always m, q1, q2, dev=false
      meme = genMeme 74, 2485, q1, q2
      send_meme(m,meme,dev)
    end

    def y_u_no_dev m, dev, command, query
      y_u_no(m,command,query,true)
    end

    def y_u_no m, command, query, dev=false
      meme = genMeme  2 , 166088, "Y U NO ", query
      send_meme(m,meme,dev)
    end

    def send_meme(m,meme,dev)
      if dev
        `curl -d "message=#{meme}" http://chat.transmit.is:8887/say`    
      else
        m.reply meme
      end
    end                      

    def genMeme genId, imgId, text0, text1="", callback=nil
      username = "bhs1"
      password = "bingdao"

      base_uri = 'http://version1.api.memegenerator.net'
      text0 = CGI.escape(text0)
      text1 = CGI.escape(text1)

      params  = "username=#{username}&password=#{password}&"
      params += "languageCode=en&generatorID=#{genId}&imageId=#{imgId}&"
      params += "text0=#{text0}&text1=#{text1}" 

      exec_path = "#{base_uri}/Instance_Create?#{params}"
      call = Curl::Easy.perform(exec_path) do |curl|
        curl.headers['User-Agent']="Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:10.0.2) Gecko/20100101 Firefox/10.0.2"
        curl.headers['Accept-Language']= "en-us,en;q=0.5"
        curl.headers['Accept-Charset']= "utf-8"
      end

      resp = JSON(call.body_str)
      if !resp["result"].nil? and !resp["result"]["instanceID"].nil?
        id = resp["result"]["instanceID"]
        return "http://images.memegenerator.net/instances/400x/#{id}.jpg"
      else
        return "http://media.tumblr.com/tumblr_lx16h52PVj1r2w0bt.png"
      end
    end

  end
end
