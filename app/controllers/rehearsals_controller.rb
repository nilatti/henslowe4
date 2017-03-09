class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :update, :destroy]
  before_action :load_rehearsal_schedule
  # GET /rehearsals
  # GET /rehearsals.json
  def index
    @rehearsals = @rehearsal_schedule.rehearsals.all
  end

  # GET /rehearsals/1
  # GET /rehearsals/1.json
  def show
  end

  # GET /rehearsals/new
  def new
    @rehearsal = Rehearsal.new
  end

  # GET /rehearsals/1/edit
  def edit
    @production = @rehearsal_schedule.production
    @scenes = @production.play.scenes.sort { |a, b| a.pretty_name <=> b.pretty_name}
    @french_scenes = @production.play.french_scenes.sort { |a, b| a.pretty_name <=> b.pretty_name}
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

  # POST /rehearsals
  # POST /rehearsals.json
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

  # PATCH/PUT /rehearsals/1
  # PATCH/PUT /rehearsals/1.json
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

  # DELETE /rehearsals/1
  # DELETE /rehearsals/1.json
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
      params.require(:rehearsal).permit(:start_time, :end_time, :space_id, :rehearsal_schedule_id, :notes, :plays, acts: [], scenes: [], french_scene_group: [])
    end
end
