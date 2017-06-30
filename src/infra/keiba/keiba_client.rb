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
      {
        name: race_dom.css('.racename > a').first.content,
        path: race_dom.css('.racename > a').first.attributes['href'].value,
      }
    }
  end

  def get_race_detail(path, race_title = nil)
    page = get_path(path)
    page.css('.bml1').map{|dom|
      waku = dom.css('td > span').first.content.strip.to_i
      num = dom.css('.umaban').first.content.strip.to_i

      horse_name_dom = dom.css('.horsename a').first
      name = horse_name_dom.content.strip
      url = horse_name_dom.attributes['href'].value.strip

      sex_age = dom.css('td')[4].content.strip.split("")
      sex = sex_age[0]
      age = sex_age[1].to_i

      burden = dom.css('td')[5].content.strip.to_f
      jockey_dom = dom.css('td')[6].css('a').first
      jockey_name = jockey_dom.content.strip
      jockey_url = jockey_dom.attributes['href'].value.strip

      odds = dom.css('td')[7].content.strip.to_f
      popularity = dom.css('td')[8].content.strip.to_i

      {
        waku: waku,
        num: num,
        name: name,
        url: url,
        sex: sex,
        age: age,
        burden: burden,
        jockey: {
          name: jockey_name,
          url: jockey_url,
        },
        odds: odds,
        popularity: popularity
      }
    }
  end
end
