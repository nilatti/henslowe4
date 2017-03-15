class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :update, :destroy]
  before_action :load_rehearsal_schedule

  def index
    @rehearsals = @rehearsal_schedule.rehearsals.all
  end

  def show
  end

  def new
    @rehearsal = Rehearsal.new
  end

  def edit
    @production = @rehearsal_schedule.production
    @scenes = @production.play.scenes.sort { |a, b| a.pretty_name <=> b.pretty_name}
    @french_scenes = @production.play.french_scenes.sort { |a, b| a.pretty_name <=> b.pretty_name}
    unless @rehearsal.actor_conflicts.empty?
      f = FindMaterialThatIsNotRehearsable.new(@production, @rehearsal)
      f.run
      @unavailable_french_scenes = f.unavailable_french_scenes
      @available_french_scenes = f.available_french_scenes
      @unavailable_scenes = f.unavailable_scenes
      @available_scenes = f.available_scenes
      @unavailable_acts = f.unavailable_acts
      @available_acts = f.available_acts
      @unavailable_actors = f.unavailable_actors
      @whole_play = f.whole_play
      @conflicts = f.conflicts
    end
  end

  def create
    @rehearsal = @rehearsal_schedule.rehearsals.build(rehearsal_params)

    respond_to do |format|
      if @rehearsal.save
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal }
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rehearsal.update(rehearsal_params)
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rehearsal.destroy
    respond_to do |format|
      format.html { redirect_to @rehearsal_schedule, notice: 'Rehearsal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_rehearsal_schedule
      if params[:rehearsal_schedule_id]
        @rehearsal_schedule = RehearsalSchedule.find(params[:rehearsal_schedule_id])
      elsif @rehearsal.rehearsal_schedule
        @rehearsal_schedule = @rehearsal.rehearsal_schedule
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_rehearsal
      @rehearsal = Rehearsal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rehearsal_params
      params.require(:rehearsal).permit(:start_time, :end_time, :title, :notes, :space_id, :rehearsal_schedule_id, :play_ids, user_ids: [], act_ids: {}, scene_ids: [], french_scene_ids: [])
    end
end
