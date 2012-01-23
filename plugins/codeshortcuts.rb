require 'cinch'

module Plugins
  class CodeShortcuts
    include Cinch::Plugin
   
    listen_to :channel

    # Listens for a ticket number reference and provides the link to codebase.
    def listen(m)
      if /#([0-9]*)/.match(m.message)
        ticket =  /#([0-9]*)/.match(m.message)[1]
        m.reply "Did someone mention ticket ##{ticket}? Here's a link: " + "https://transmit.codebasehq.com/projects/brand-regard/tickets/" + ticket
      end
    end
    
  end
end
