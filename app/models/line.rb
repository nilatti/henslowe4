class Line < ActiveRecord::Base
  attr_accessor :stripped_line_number
  belongs_to :french_scene
  belongs_to :character

  def self.scene_order(arr) #array of lines
    arr.each do |line|

      line.stripped_line_number = line.line_number.match(/^(SD(\s|\.))*\d+\.\d+\.(\d+)\.*\d*$/).captures[2].to_i
      puts line.stripped_line_number
    end
    sorted_arr = arr.sort { |a, b| a.stripped_line_number <=> b.stripped_line_number}
  end

end
