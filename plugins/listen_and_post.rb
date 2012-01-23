require 'cinch'
require "sinatra"
require "yaml"
require "json"

HOST = '0.0.0.0'
PORT = 8887

module Plugins
  class ListenAndPost
    include Cinch::Plugin

    def initialize(*args)
      set :bind, HOST 
      set :port, PORT
      set :logging, false
      set :lock, true
      puts 'Setup web server'
    end

    configure do
      set :bind, HOST 
      set :port, PORT
      set :logging, false
      set :lock, true
    end

    get "/" do
      "Brandur lives here. Direct your hooks to /github."
    end

    post "/say" do
      Brandur.say params[:message]
    end

    post "/github" do
      push = JSON.parse(params[:payload])
      repo = push["repository"]["name"]
      branch = push["ref"].gsub(/^refs\/heads\//,"")

      # sort commits by timestamp
      push["commits"].sort! do |a,b|
       ta = tb = nil
        begin
          ta = DateTime.parse(a["timestamp"])
        rescue ArgumentError
          ta = Time.at(a["timestamp"].to_i)
        end

        begin
         tb = DateTime.parse(b["timestamp"])
        rescue ArgumentError
          tb = Time.at(b["timestamp"].to_i)
        end
    
        ta <=> tb
      end
      
      Brandur.say "Yeah! Kudos! \0033 #{push["commits"].last["author"]["name"]} \003 pushed to #{branch} on #{repo}! His commits were:"
      # output first 3 commits
      push["commits"][0..2].each do |c|
        Brandur.say "#{c["message"]}"
      end

      if push["commits"].length-2 > 0
        Brandur.say  "... and #{push["commits"].length-2} more"
      end

    end   
  end
end

