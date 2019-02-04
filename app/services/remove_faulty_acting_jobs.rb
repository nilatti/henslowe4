class RemoveFaultyActingJobs
  # mostly for noncanonical copy plays
  attr_accessor :jobs, :play, :production, :to_destroy

  def initialize(production:)
    @play = production.play
    @production = production
    @to_destroy = []
  end

  def run
    find_jobs
    find_faulty_jobs
    destroy_faulty_jobs
  end

  def find_faulty_jobs
      @to_destroy = @jobs.select { |job| job.character && job.character.play.id != play.id }
  end

  def find_jobs
    @jobs = @production.jobs.acting
  end

  def destroy_faulty_jobs
    @to_destroy.each {|job| job.destroy }
  end
end
