class ReportLineGaps
  attr_accessor :gaps, :play

  def initialize(play:)
    @play = play
    @gaps = []
  end

  def run
    find_and_check_lines
    print_gaps_list
  end

  def find_and_check_lines
    ordered_scenes = Scene.play_order(@play.scenes)
    ordered_scenes.each do |scene|
      n = 0
      scene.french_scenes.each do |french_scene|
        french_scene.lines.each do |line|
          next_line = n + 1
          ln = extract_line_number(line)
          unless ln == n || ln == next_line
            puts "ln #{ln} does not match #{n} or #{next_line}. line number is #{line.line_number}"
            add_to_gaps_list(line)
          end
          n = ln
        end
      end
    end
  end

  def extract_line_number(line)
    puts "line is #{line.id}"
    puts "line number is #{line.line_number}"
    line.line_number.match(/^(SD(\s|\.))*\d+\.\d+\.(\d+)\.*\d*$/).captures[2].to_i
  end

  def add_to_gaps_list(line)
    @gaps << line.line_number
  end

  def print_gaps_list
    @gaps.each {|g| puts g}
  end
end
