require 'telegram/bot'
require 'rest-client'
require 'dotenv/load'
require_relative './vk.rb'
require_relative './messages.rb'

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
  bot.listen do |message|
    command, param = message.text.split(' ', 2)
    case command
    when '/start'
      Messages.start(bot, message)
    when '/help'
      Messages.help(bot, message)
    when '/list'
      Messages.list(bot, message)
    when '/source'
      Messages.source(bot, message)
    when '/random'
      Messages.random(bot, message, param)
    else
      Messages.other(bot, message)
    end
  end
end
