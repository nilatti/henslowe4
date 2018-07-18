class FindDoublingProblems
  attr_accessor :castings, :characters, :french_scenes, :problems
  def initialize(user, production)
    @user = user
    @production = production
    @characters = @user.castings_for_production(@production)
    @french_scenes = user.french_scenes_for_production(@production)
    @problems = Hash.new { |hash, key| hash[key] = Array.new}
  end

  def find_problems
    @problems = @french_scenes.select{|key, hash| hash.size > 1}
    @problems.each { |k, v| puts "#{k.pretty_name}: #{v}" }
    return @problems
  end

  def run
    find_problems
  end
end
