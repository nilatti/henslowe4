class FindDoublingProblems
  attr_accessor :castings, :characters
  def initialize(user, production)
    @user = user
    @production = production
    @characters = []
    get_all_characters_for_actor
  end

  def get_all_characters_for_actor
    @characters = @user.castings_for_production(@production)
  end

  def doubling_problems
    fs = []
    problems = []
    puts "number of characters for #{@user.name} is #{@characters.size}"
    @characters.each do |character|
      unless character.nil?
        character.french_scenes.each do |french|
          unless fs.include?(french)
            fs << french
          else
            problems << french
          end
        end
      end
    end
    return problems
  end
end
