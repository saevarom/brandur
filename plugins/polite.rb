module Plugins
  class Polite
    include Cinch::Plugin
    
    match /(thanks|thank you|cheers|nice one|takk|takk fyrir)/i, use_prefix: false, method: :random
    match /(ty|thx)/i, use_prefix: false, method: :random_short
    match /(hello|hi|sup|howdy|good (morning|evening|afternoon)|h\303\246)/iu, use_prefix: false, method: :hello
    match /(bye|night|goodbye|good night|bless)/iu, use_prefix: false, method: :random_goodbye
    
    Responses = [
      "You're welcome.",
      "No problem.",
      "Anytime.",
      "That's what I'm here for!",
      "You are more than welcome.",
      "You don't have to thank me, I'm your loyal servant.",
      "Don't mention it."
    ]

    ShortResponses = [
      'vw',
      'np',
    ]

    FarewellResponses = [
      'Goodbye',
      'Have a good evening',
      'Bye',
      'Take care',
      'Nice speaking with you',
      'See you later'
    ]

    def hello m, command
      m.reply "#{@bot.nick} at your service!"
    end
    
    def random m, command
      m.reply Responses[rand(Responses.length)]
    end

    def random_short m, command
      m.reply ShortResponses[rand(ShortResponses.length)]
    end

    def random_goodbye m, command
      m.reply FarewellResponses[rand(FarewellResponses.length)]
    end

  end
end

