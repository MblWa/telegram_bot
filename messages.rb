# This class is used to form messages to send for user in chat.
class Messages
  # Predefined commands in chat
  @commands = { '/start' => 'Greeting message;',
                '/help' => 'Prints this message.',
                '/list' => 'Prints list of all albums in das_chat_boot-group available;',
                '/random album_name (optional)' => 'Shows you some random picture from random album, with the name of album as parameter after whitespace - shows one photo from exact album;',
                '/all album_name' => 'Shows you all links to the photos in the album;',
                '/source' => 'Show some code of this bot.' }

  class << self
    def start
      <<-TEXT
      Hello!
      This bot was remade to show some of my skills in Ruby to get some work.
      If you are interested in the result, start with the command '/help' to view all available commands.
      This bot will react at your commands. Be sure to type them down correctly.
      Everything after your command will be ignored (unless it's '/random' command).
      Good Luck!
      TEXT
    end

    def help
      mes = ''
      # Generating message string from available commands and descrip.
      @commands.each.with_index do |(com, descrip), i|
        mes << (i + 1).to_s << '. ' << com << ' - ' << descrip << "\n"
      end

      mes.chop
    end

    def list
      mes = ''
      albums = Vk.albums_get

      if albums.empty?
        mes = 'Sorry, no albums in this group '
      else
        albums.each.with_index do |(key, value), i|
          mes << (i + 1).to_s << '. ' << key << ' | Фотографий в альбоме: ' << value[1].to_s << "\n"
        end
      end

      mes.chop
    end

    def random(param = '')
      Vk.photos_get(param)
    end

    def all(param = '')
      Vk.all_get(param)
    end

    def source
      Vk.source_get
    end

    def other
      "Unknown command, for all available commands type '/help'"
    end
  end
end
