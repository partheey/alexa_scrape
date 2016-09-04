class FetchRank

  def initialize
    @base_url = 'http://data.alexa.com/data?cli=10&url=http://'
  end

  def get(url)
    request_url = @base_url+url
    alexa_response = open(request_url)
    parsed_xml = Nokogiri::XML(alexa_response)
    find_rank(parsed_xml)
  end

  def find_rank(parsed_xml)
    rank = parsed_xml.xpath('//SD//REACH').first['RANK']
    rank.blank? ? false : rank.to_i
  end
end
