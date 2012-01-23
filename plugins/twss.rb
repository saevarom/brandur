require 'cinch'

module Plugins
  class TWSS
    include Cinch::Plugin
    
    match /.*(big|small|long|hard|soft|mouth|face|good|fast|slow|in there|on there|in that|on that|wet|dry|on the|in the|suck|blow|jaw|all in|fit that|fit it|hurts|hot|huge|balls|stuck).*/i, use_prefix: false

    def execute m, command
      m.reply "THAT'S WHAT SHE SAID!"
    end
  end
end

