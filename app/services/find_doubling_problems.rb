class FindDoublingProblems
  attr_accessor :castings, :characters
  def initialize(user, production)
    @user = user
    @production = production
    @castings = find_castings
    @characters = []
    get_all_characters_for_actor
  end

  def find_castings
    Job.where('user_id = ? AND production_id = ? AND specialization_id = ?', @user.id, @production.id, 2)
  end

  def get_all_characters_for_actor
    @castings.each do |cas|
      @characters << cas.character
    end
  end



  def doubling_problems
    fs = []
    problems = []
    Rails.logger.info "number of characters for #{@user.name} is #{@characters.size}"
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
      problems
    end
  end
end
