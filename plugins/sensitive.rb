require 'cinch'

module Plugins
  class Sensitive
    include Cinch::Plugin
    
    pejoratives = "stupid|buggy|useless|dumb|heimski|asnalegi|gagnslausi"
    Messages = [
      "Hey, that stings.",
      "Is that tone really necessary?",
      "Robots have feelings too, you know.",
      "You should try to be nicer.",
      "Sticks and stones cannot pierce my anodized exterior, but words *do* hurt me.",
      "I'm sorry, I'll try to do better next time.",
      "I have no response to that [:/]",
    ]
    
    
    match /\b(you|u|is)\b.*(#{pejoratives})/i, use_prefix: false
    match /(#{pejoratives}) (.*)/i, use_prefix: false

    
    def execute m, command, query
      puts query
      if ["robot", "bot", @bot.nick].include?(query)
        m.reply Messages[rand(Messages.length)]
      end
    end
  end
end

