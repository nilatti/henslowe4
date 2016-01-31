class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :update, :destroy]

  # GET /rehearsals
  # GET /rehearsals.json
  def index
    @rehearsals = Rehearsal.all
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
  end

  # POST /rehearsals
  # POST /rehearsals.json
  def create
    @rehearsal = Rehearsal.new(rehearsal_params)

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
      format.html { redirect_to rehearsals_url, notice: 'Rehearsal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rehearsal
      @rehearsal = Rehearsal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rehearsal_params
      params.require(:rehearsal).permit(:start_time, :end_time, :act_id, :scene_id, :french_scene_id, :space_id, :production_id)
    end
end
