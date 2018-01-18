# This class is used to get information from VK.com api.
# All methods are used in Messages class (messages.rb)
class Vk
  @albums = {}
  @photos = []
  class << self
    def albums_get
      response = RestClient.get("https://api.vk.com/method/photos.getAlbums?owner_id=#{ENV['USER_ID']}&access_token=#{ENV['VK_API_TOKEN']}")

      parsed = JSON.parse(response.body)['response']
      parsed.each { |elem| @albums[elem['title']] = [elem['aid'], elem['size']] } unless parsed.nil?

      @albums
    end

    def photos_get(album = '')
      albums_get if @albums.empty?
      return 'No albums in the group. Try to add some.' if @albums.empty?

      a_id = (album == '' || !@albums.keys.include?(album) ? @albums.keys.sample : album)

      response = RestClient.get("https://api.vk.com/method/photos.get?owner_id=#{ENV['USER_ID']}&album_id=#{@albums[a_id][0]}&access_token=#{ENV['VK_API_TOKEN']}")
      parsed = JSON.parse(response.body)['response']
      @photos = parsed.map { |photo| photo['src_big'] }

      @photos.sample || 'No photos in that album, sorry!'
    end

    def all_get(album = '')
      albums_get if @albums.empty?
      return 'No albums in the group. Try to add some.' if @albums.empty?
      return 'Sorry, there is no such album in the group' if album == '' || !@albums.keys.include?(album)
      photos_get(album)

      @photos.empty? ? 'Sorry, there are no photos.' : @photos.join("\n")
    end

    def source_get
      response = RestClient.get("https://api.vk.com/method/groups.getById?group_ids=#{ENV['USER_ID'].to_i.abs}&fields=description&access_token=#{ENV['VK_API_TOKEN']}")
      parsed = JSON.parse(response.body)['response']
      if parsed.nil?
        'Sorry, no description in the group.'
      else
        parsed.first['description'].gsub('<br>', "\n")
      end
    end
  end
end
