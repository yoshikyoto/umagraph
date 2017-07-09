require 'test_helper'

class RaceTest < ActionDispatch::IntegrationTest
  test "レース情報を見れる" do
    race = Race.find('c201703020402')
    assert_instance_of(Race, race)
    assert_instance_of(String, race.name)
    race_horses = race.race_horses
    assert_instance_of(Hash, race_horses)
    race_horses.each{|num, race_horse|
      assert_instance_of(RaceHorse, race_horse)
      assert_instance_of(Horse, race_horse.horse)
      assert_instance_of(Jockey, race_horse.jockey)
    }
  end
end
