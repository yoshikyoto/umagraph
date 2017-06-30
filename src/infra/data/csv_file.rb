# coding: utf-8

require 'fileutils'
require 'csv'

class CsvFile
  def initialize()
    @dir = '../../../data'
  end

  def save(name, time, data)
    race_dir = @dir + '/' + name
    FileUtils.mkdir_p(race_dir)
    puts data
    csv_path = race_dir + '/' + time.to_s + '.csv'
    CSV.open(csv_path, 'wb') do |csv|
      data.each{|item|
        csv << item
      }
    end
  end
end
