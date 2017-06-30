# coding: utf-8

require '../../infra/keiba/keiba_client'
require '../../infra/data/csv_file'
require './entity/race'
require './entity/horce'
require './entity/race_horse'
require './entity/jockey'
require 'date'

class KeibaRepository

  def initialize()
    @client = KeibaClient.new()
    @csv = CsvFile.new()
  end

  def main_races()
    list = @client.get_main_race_list
    list.map{|race_hash|
      race(race_hash[:path], race_hash[:name])
    }
  end

  def race(path, race_title)
    race_horses = @client.get_race_detail(path, race_title).map{|horse_hash|
      horse = Horse.new(horse_hash[:name], horse_hash[:url])
      jockey = Jockey.new(horse_hash[:jockey][:name], horse_hash[:jockey][:url])
      race_horce = RaceHorce.new(
        horse_hash[:waku],
        horse_hash[:num],
        horse,
        horse_hash[:sex],
        horse_hash[:age],
        horse_hash[:burden],
        jockey,
        horse_hash[:odds],
        horse_hash[:popularity])
    }
    Race.new(race_title, race_horses)
  end

  def output_csv(race, time)
    puts race.name
    data = race.race_horses.map{|race_horse|
      [
        race_horse.horse.name,
        race_horse.odds,
      ]
    }
    @csv.save(race.name, time, data)
  end
end

r = KeibaRepository.new()
race = r.main_races[0]
r.output_csv(race, Time.now.to_i)

race = r.race('/?pid=race_old&id=c201703020106', '福島6R２歳新馬')
r.output_csv(race, Time.now.to_i)

