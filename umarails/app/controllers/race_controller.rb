class RaceController < ApplicationController
  def races
  end

  def race
    @race_id = params[:race_id]
    @race = Race.find(@race_id)
  end
end
