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

  	if m.action?
  		f.write("#{nick} ")
  	elsif speaker != nick
		f.write("#{nick} says ")
  	end

  	text = m.action? ? m.action_message : query

  	speaker = nick
  	f.write("#{text}\n")
  	f.flush
  end
end

bot.start
