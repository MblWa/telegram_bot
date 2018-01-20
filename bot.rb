require 'telegram/bot'
require 'rest-client'
require 'dotenv/load'
require_relative './vk.rb'
require_relative './messages.rb'
# Before starting this script you should set 3 ENV-constant:
# TELEGRAM_TOKEN - your bot's token, can be recieved in Telegram app
# VK_API_TOKEN - token of your app, can be recieved at vk.com
# USER_ID - id of the group, you want to work with.
# It's important to corectly type it in, as it starts with '-'
# For example USER_ID='-11111'
# All constants are set in .env file.
if [ENV['TELEGRAM_TOKEN'], ENV['USER_ID'], ENV['VK_API_TOKEN']].include?(nil)
  token = %w[TELEGRAM_TOKEN USER_ID VK_API_TOKEN].select { |x| ENV[x].nil? }
  raise "Unable to work properly without #{token.join(', ')}. Set them in .env"
end

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
  bot.listen do |message|
    command, param = message.text.split(' ', 2)
    begin
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
            when '/all'
              Messages.all(param)
            else
              Messages.other
            end
    rescue StandardError => error
      mes = error.to_s
    end
    bot.api.sendMessage(chat_id: message.chat.id, text: mes)
  end
end
