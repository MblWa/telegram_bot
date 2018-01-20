# This class is used to get information from VK.com api.
# All methods are used in Messages class (messages.rb)
class Vk
  @albums = {}
  @photos = []
  class << self
    def albums_get
      parsed = get('albums')

      parsed.each { |elem| @albums[elem['title']] = [elem['aid'], elem['size']] } unless parsed.nil?

      @albums
    end

    def photos_get(album = '')
      albums_get if @albums.empty?
      return 'No albums in the group. Try to add some.' if @albums.empty?

      a_id = (album == '' || !@albums.keys.include?(album) ? @albums.keys.sample : album)
      parsed = get('photos', @albums[a_id][0].to_s)
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
      parsed = get('source')

      if parsed.nil?
        'Sorry, no description in the group.'
      else
        parsed.first['description'].gsub('<br>', "\n")
      end
    end

    private

    def get(method_name, a_id = '')
      head = 'https://api.vk.com/method/'
      tail = "&access_token=#{ENV['VK_API_TOKEN']}"
      rsp = case method_name
            when 'albums'
              RestClient.get(head << "photos.getAlbums?owner_id=#{ENV['USER_ID']}" << tail)
            when 'photos'
              RestClient.get(head << "photos.get?owner_id=#{ENV['USER_ID']}&album_id=" << a_id << tail)
            when 'source'
              RestClient.get(head << "groups.getById?group_ids=#{ENV['USER_ID'].to_i.abs}&fields=description" << tail)
            end

      return JSON.parse(rsp.body)['response'] if rsp.code == 200
      raise 'Error code: ' << rsp.code.to_s << "\n" << 'Vk.api seems to be down.'
    end
  end
end
