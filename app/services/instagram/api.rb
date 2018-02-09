module Instagram
    class Api
        require 'httparty'
        require 'json'

        URL = 'https://api.instagram.com/v1/users/self/media/recent/?access_token='

        def initialize(params)
            @access_token = params[:access_token]
        end

        def feed_pics
            extract_pics_urls(feed_pics_service, "standard_resolution")
        end

        private

        attr_reader :access_token

        def feed_pics_service
            url = "#{Api::URL}#{access_token}"
            uri = URI.parse(URI.escape(url))
            response = HTTParty.get(uri)
            data = response.parsed_response
        end

        def extract_pics_urls(pics_hash, resolution)
            pics_hash["data"].map { |d| d["images"][resolution]["url"] }
        end
    end
end
