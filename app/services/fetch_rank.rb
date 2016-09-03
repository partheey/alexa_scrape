class FetchRank

  def initialize
    @base_url = 'http://data.alexa.com/data?cli=10&url=http://'
  end

  def get(url)
    request_url = @base_url+url
    response = Nokogiri::XML(open(request_url))
    find_rank(response)
  end

  def find_rank(response)
    rank = response.xpath('//SD//REACH').first['RANK']
    rank.blank? ? false : rank.to_i
  end
end
