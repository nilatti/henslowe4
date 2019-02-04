class RemoveFaultyLines
  # mostly for noncanonical copy plays
  attr_accessor :lines, :play, :to_destroy

  def initialize(play:)
    @play = play
    @to_destroy = []
  end

  def run
    find_lines
    find_faulty_lines
    destroy_faulty_lines
  end

  def find_faulty_lines
      puts "finding faulty lines"
      @to_destroy = @lines.select { |line| line.character && line.character.play.id != play.id }
  end

  def find_lines
    puts "finding lines"
    @lines = @play.lines
  end

  def destroy_faulty_lines
    puts "destroying lines"
    @to_destroy.each {|line| line.destroy }
  end
end
