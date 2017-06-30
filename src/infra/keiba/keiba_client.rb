# coding: utf-8

require 'net/https'
require 'nokogiri'

class KeibaClient

  def initialize()
    @base_url = 'http://race.netkeiba.com'
  end

  def get_params(params = {})
    uri = URI.parse(@base_url)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get(uri)
    charset = 'euc-jp' # netkeibaのエンコーディング決め打ち
    Nokogiri::HTML.parse(res, nil, charset)
  end

  def get_path(path = "/")
    uri = URI.parse(@base_url + path)
    res = Net::HTTP.get(uri)
    charset = 'euc-jp' # netkeibaのエンコーディング決め打ち
    Nokogiri::HTML.parse(res, nil, charset)
  end

  def get_main_race_list()
    page = get_params({acc_param: 'race'})
    page.css('.today_mainrace').map{|race_dom|
      hash = parse_race(race_dom)
      get_race_detail(hash[:path], hash[:name])
    }
  end

  def parse_race(race_dom)
    {
      name: race_dom.css('.racename > a').first.content,
      path: race_dom.css('.racename > a').first.attributes['href'].value,
    }
  end

  def get_race_detail(path, race_title = nil)
    puts 'get_race_detail'
    page = get_path(path)
    page.css('.bml1').map{|bml_dom|
      
    }
  end
end

client = KeibaClient.new()
client.get_main_race_list()
