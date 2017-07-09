require 'net/https'
require 'nokogiri'

class Race
  attr_reader :name, :race_horses

  def initialize(name, race_horses)
    @name = name
    @race_horses = race_horses
  end

  def race_list(id)
    params = {
      pid: "race_list",
      id: id,
    }
  end

  def self.find(id)
    get_race(id)
  end

  def self.get_race(id)
    params = {
      pid: 'race',
      id: id,
      mode: 'shutuba',
    }
    page = request_get("/", params)
    race_name = page.css('h1').first.content.strip.to_s

    race_horses = {}
    page.css('table.race_table_01 tr').each{|dom|
      next if dom.css('td').size <= 0 #見出しの場合など

      cells = dom.css('td') #テーブルの各セル

      waku = cells[0].content.strip.to_i
      num = dom.css('.umaban').first.content.strip.to_i

      horse_name_dom = dom.css('.h_name').first
      name = horse_name_dom.content.strip
      url = horse_name_dom.css('a').attribute('href').value.strip

      sexage_burden = cells[6].inner_html.split("<br>")
      sex_age = sexage_burden[0].strip.split("")
      sex = sex_age[0].strip
      age = sex_age[1].strip.to_i
      burden = sexage_burden[1].strip.to_f

      jockey_dom = cells[6].css('a').first
      jockey_name = jockey_dom.content.strip
      jockey_url = jockey_dom.attribute('href').value.strip
      jockey = Jockey.new(jockey_name, jockey_url)

      odds_popularity = cells[7].inner_html.split("<br>")
      odds = odds_popularity[0].strip.to_f
      popularity = odds_popularity[1].match(/\d+/)[0].to_i

      horse = Horse.new(name, url)
      race_horse = RaceHorse.new(waku, num, horse, sex, age, burden, jockey, odds, popularity)

      race_horses[num] = race_horse
    }
    Race.new(race_name, race_horses)
  end

  def self.request_get(path = "/", params = {})
    base_url = 'http://race.netkeiba.com'
    uri = URI.parse(base_url + path)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get(uri)
    charset = 'euc-jp' # netkeibaのエンコーディング決め打ち
    Nokogiri::HTML.parse(res, nil, charset)
  end
end
