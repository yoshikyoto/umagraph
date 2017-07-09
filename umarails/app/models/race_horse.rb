class RaceHorse
  attr_reader :waku, :num, :horse, :sex, :age, :burden, :jockey, :odds, :popularity
  def initialize(waku, num, horse, sex, age, burden, jockey, odds, popularity)
    @waku = waku
    @num = num
    @horse = horse
    @sex = sex
    @age = age
    @burden = burden
    @jockey = jockey
    @odds = odds
    @popularity = popularity
  end
end
