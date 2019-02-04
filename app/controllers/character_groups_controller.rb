class CharacterGroupsController < ApplicationController
  before_action :set_character_group, only: [:show, :edit, :update, :destroy]

  # GET /character_groups
  # GET /character_groups.json
  def index
    @character_groups = CharacterGroup.all
  end

  # GET /character_groups/1
  # GET /character_groups/1.json
  def show
  end

  # GET /character_groups/new
  def new
    @character_group = CharacterGroup.new
  end

  # GET /character_groups/1/edit
  def edit
  end

  # POST /character_groups
  # POST /character_groups.json
  def create
    @character_group = CharacterGroup.new(character_group_params)

    respond_to do |format|
      if @character_group.save
        format.html { redirect_to @character_group, notice: 'Character group was successfully created.' }
        format.json { render :show, status: :created, location: @character_group }
      else
        format.html { render :new }
        format.json { render json: @character_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /character_groups/1
  # PATCH/PUT /character_groups/1.json
  def update
    respond_to do |format|
      if @character_group.update(character_group_params)
        format.html { redirect_to @character_group, notice: 'Character group was successfully updated.' }
        format.json { render :show, status: :ok, location: @character_group }
      else
        format.html { render :edit }
        format.json { render json: @character_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_groups/1
  # DELETE /character_groups/1.json
  def destroy
    @character_group.destroy
    respond_to do |format|
      format.html { redirect_to character_groups_url, notice: 'Character group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_character_group
    @character_group = CharacterGroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def character_group_params
    params.require(:character_group).permit(:name, :play_id, :corresp, :xml_id)
  end
end
