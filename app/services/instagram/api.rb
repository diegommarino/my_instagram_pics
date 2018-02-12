module Instagram
    class Api
        require 'httparty'
        require 'json'

        URL = 'https://api.instagram.com/v1/users/self/media/recent/?access_token='

        def initialize(params)
            @access_token = params[:access_token]
        end

        def feed_pics(with_comments=false, resolution=:standard_resolution)
            res = {
                thumbnail: 'thumbnail',
                low_resolution: 'low_resolution',
                standard_resolution: 'standard_resolution'
            }.fetch(resolution)

            service_response = feed_pics_service
            if service_response["meta"]["code"] == 200
                extract_pics_urls(service_response, res, with_comments)
            else
                nil
            end
        end

        private

        attr_reader :access_token

        def feed_pics_service
            url = "#{Api::URL}#{access_token}"
            uri = URI.parse(URI.escape(url))
            response = HTTParty.get(uri)
            data = response.parsed_response
        end

        def extract_pics_urls(pics_hash, resolution, with_comments)
            if with_comments
                pics_hash["data"].map { |d| { url: d["images"][resolution]["url"], comment: d["caption"].nil? ? nil : d["caption"]["text"]}}
            else
                pics_hash["data"].map { |d| { url: d["images"][resolution]["url"] }}
            end
        end
    end
end
