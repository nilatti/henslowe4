class RehearsalMaterialsController < ApplicationController
  before_action :set_rehearsal_material, only: [:show, :edit, :update, :destroy]

  # GET /rehearsal_materials
  # GET /rehearsal_materials.json
  def index
    @rehearsal_materials = RehearsalMaterial.all
  end

  # GET /rehearsal_materials/1
  # GET /rehearsal_materials/1.json
  def show
  end

  # GET /rehearsal_materials/new
  def new
    @rehearsal_material = RehearsalMaterial.new
  end

  # GET /rehearsal_materials/1/edit
  def edit
  end

  # POST /rehearsal_materials
  # POST /rehearsal_materials.json
  def create
    @rehearsal_material = RehearsalMaterial.new(rehearsal_material_params)

    respond_to do |format|
      if @rehearsal_material.save
        format.html { redirect_to @rehearsal_material, notice: 'Rehearsal material was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal_material }
      else
        format.html { render :new }
        format.json { render json: @rehearsal_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rehearsal_materials/1
  # PATCH/PUT /rehearsal_materials/1.json
  def update
    respond_to do |format|
      if @rehearsal_material.update(rehearsal_material_params)
        format.html { redirect_to @rehearsal_material, notice: 'Rehearsal material was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal_material }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rehearsal_materials/1
  # DELETE /rehearsal_materials/1.json
  def destroy
    @rehearsal_material.destroy
    respond_to do |format|
      format.html { redirect_to rehearsal_materials_url, notice: 'Rehearsal material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rehearsal_material
      @rehearsal_material = RehearsalMaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rehearsal_material_params
      params.require(:rehearsal_material).permit(:rehearsal_id, :play_id, :act_id, :scene_id, :french_scene_id)
    end
end
