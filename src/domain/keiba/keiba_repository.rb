# coding: utf-8

require '../../infra/keiba/keiba_client'
require './entity/horce'
require './entity/race_horse'
require './entity/jockey'

class KeibaRepository

  def initialize()
    @client = KeibaClient.new()
  end
  
  def main_races()
    list = @client.get_main_race_list
    list.map{|race_hash|
      @client.get_race_detail(race_hash[:path], race_hash[:name]).map{|horse_hash|
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
    }
  end
end

s = KeibaRepository.new()
puts s.main_races()

