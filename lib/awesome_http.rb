require 'net/http'
require 'uri'

class AwesomeHTTP
  def self.get(url, params)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if url =~ /^https/
    append_query(uri, params)
    response = http.get(uri.path + "?" + uri.query)
  end

  def self.append_query(uri, params)
    unless params == nil
      if uri.query
        uri.query = uri.query + "&" + params.to_query
      else
        uri.query = params.to_query
      end
    end
    uri
  end
end