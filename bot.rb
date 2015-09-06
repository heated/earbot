require 'cinch'

f = File.open('logs.txt', 'w')

speaker = nil

bot = Cinch::Bot.new do
  configure do |c|
    c.server = ARGV[0]
    c.channels = [ARGV[1]]
    c.nick = 'EarBot'
  end

  on :message, /(.+)/ do |m, query|
  	nick = m.user.nick

  	if speaker != nick
  		f.write("#{nick} says ")
  	end

  	speaker = nick
  	f.write("#{query}\n")
  	f.flush
  end
end

bot.start
