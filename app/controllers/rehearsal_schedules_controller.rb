class RehearsalSchedulesController < ApplicationController
  before_action :set_rehearsal_schedule, only: [:show, :edit, :update, :destroy]
  before_action :load_production

  # GET /rehearsal_schedules
  # GET /rehearsal_schedules.json
  def index
    @rehearsal_schedules = RehearsalSchedule.all
  end

  # GET /rehearsal_schedules/1
  # GET /rehearsal_schedules/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        date = Date.today
        render pdf: "#{@rehearsal_schedule.production.play.title}_schedule_#{date}", layout: 'pdf.html.erb'   # Excluding ".pdf" extension.

      end
    end
  end

  # GET /rehearsal_schedules/new
  def new
    @rehearsal_schedule = RehearsalSchedule.new
  end

  # GET /rehearsal_schedules/1/edit
  def edit
  end

  # POST /rehearsal_schedules
  # POST /rehearsal_schedules.json
  def create
    @rehearsal_schedule = @production.rehearsal_schedules.build(rehearsal_schedule_params)

    respond_to do |format|
      if @rehearsal_schedule.save
        format.html { redirect_to @rehearsal_schedule, notice: 'Rehearsal schedule was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal_schedule }
      else
        format.html { render :new }
        format.json { render json: @rehearsal_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rehearsal_schedules/1
  # PATCH/PUT /rehearsal_schedules/1.json
  def update
    respond_to do |format|
      if @rehearsal_schedule.update(rehearsal_schedule_params)
        format.html { redirect_to @rehearsal_schedule, notice: 'Rehearsal schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal_schedule }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rehearsal_schedules/1
  # DELETE /rehearsal_schedules/1.json
  def destroy
    @rehearsal_schedule.destroy
    respond_to do |format|
      format.html { redirect_to rehearsal_schedules_url, notice: 'Rehearsal schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_production
      if params[:production_id]
        @production = Production.find(params[:production_id])
      elsif @rehearsal_schedule.production
        @production = @rehearsal_schedule.production
      end
    end

    def set_rehearsal_schedule
      @rehearsal_schedule = RehearsalSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rehearsal_schedule_params
      params.require(:rehearsal_schedule).permit(:production_id, :space_id, :start_date, :end_date, :start_time, :end_time, :interval, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
    end
end
