class FetchRank

  def initialize
    @base_url = 'http://data.alexa.com/data?cli=10&url='
  end

  def get(url)
    request_url = @base_url+url
    alexa_response = open(request_url)
    if ['408', '504', '598', '599'].include?(alexa_response.try(:status).try(:first))
      error = "Timeout Error !! Can't retrive data from alexa. Please again after some time."
      return false, error
    end
    parsed_xml = Nokogiri::XML(alexa_response)
    error = "Website not found in alexa !!" and return false, error if parsed_xml.search('RANK').blank?
    return find_rank(parsed_xml), nil
  end

  def find_rank(parsed_xml)
    rank = parsed_xml.xpath('//SD//REACH').try(:first).try(:[], 'RANK')
    rank.blank? ? false : rank.to_i
  end
end
