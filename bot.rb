require 'telegram/bot'
require 'rest-client'
require 'dotenv/load'
require_relative './vk.rb'
require_relative './messages.rb'

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
  bot.listen do |message|
    command, param = message.text.split(' ', 2)
    mes = case command
          when '/start'
            Messages.start
          when '/help'
            Messages.help
          when '/list'
            Messages.list
          when '/source'
            Messages.source
          when '/random'
            Messages.random(param)
          else
            Messages.other
          end

    bot.api.sendMessage(chat_id: message.chat.id, text: mes)
  end
end
