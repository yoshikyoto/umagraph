# coding: utf-8

class Race
  attr_reader :name, :race_horses
  def initialize(name, race_horses)
    @name = name
    @race_horses = race_horses
  end
end
