# coding: utf-8

require_relative '../domain/keiba/keiba_repository'

r = KeibaRepository.new()
race = r.main_races[0]
r.output_csv(race, Time.now.to_i)

