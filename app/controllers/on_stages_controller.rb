class OnStagesController < ApplicationController
  before_action :set_on_stage, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @on_stage = OnStage.new
  end

  def edit
  end

  def create
    @on_stage = OnStage.new(on_stage_params)
    

    respond_to do |format|
      if @on_stage.save
        format.html { redirect_to @on_stage.french_scene, notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @on_stage }
      else
        format.html { render :new }
        format.json { render json: @on_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @on_stage.update(on_stage_params)
        format.html { redirect_to @on_stage.french_scene, notice: 'Space was successfully updated.' }
        format.json { respond_with_bip(@on_stage) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@on_stage) }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @on_stage.destroy
    respond_to do |format|
      format.html { redirect_to @on_stage.french_scene, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_on_stage
      @on_stage = OnStage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def on_stage_params
      params.require(:on_stage).permit(:character_id, :french_scene_id, :nonspeaking)
    end
end
