class ScenesController < ApplicationController
  load_and_authorize_resource :act
  load_and_authorize_resource :scene, :through => :act, :shallow => true

  before_action :set_scene, only: [:show, :edit, :update, :destroy]
  before_action :set_act
  before_action :set_play, only: [:edit]

  # GET /scenes
  # GET /scenes.json
  def index
    @scenes = Scene.where("act_id = #{@act.id}")
  end

  # GET /scenes/1
  # GET /scenes/1.json
  def show

    scenes = @scene.act.play.scenes
    scenes = scenes.sort { |a, b| a.pretty_name <=> b.pretty_name }
    index = scenes.index { |s| s.id == @scene.id }

    @next = scenes[index + 1]
    if index > 0
      @previous = scenes[index-1]
    end
    @production = @scene.act.play.production
    if @production
      @actors = @scene.actors_called(@production.id)
    end
    @characters = @scene.characters.uniq.reject {|character| character.play_id != @scene.act.play_id}
  end

  # GET /scenes/new
  def new
    @scene = Scene.new
  end

  # GET /scenes/1/edit
  def edit
    @production = Production.find_by(:play_id == @play.id)
    @users = @production.involved_users
  end

  # POST /scenes
  # POST /scenes.json
  def create
    @scene = @act.scenes.build(scene_params)

    respond_to do |format|
      if @scene.save
        format.html { redirect_to @act, notice: 'Scene was successfully created.' }
        format.json { render :show, status: :created, location: @scene }
      else
        format.html { render :new }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenes/1
  # PATCH/PUT /scenes/1.json
  def update
    respond_to do |format|
      if @scene.update(scene_params)
        puts "scene params: #{scene_params}"
        if scene_params["character_ids"]

        end
        format.html { redirect_to @scene.act, notice: 'Scene was successfully updated.' }
        format.json { respond_with_bip(@scene) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@scene) }
      end
    end
  end

  # DELETE /scenes/1
  # DELETE /scenes/1.json
  def destroy
    @scene.destroy
    respond_to do |format|
      format.html { redirect_to @act, notice: 'Scene was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scene
      @scene = Scene.find(params[:id])
    end

    def set_act
      if params[:act_id]
        @act = Act.find(params[:act_id])
      end
    end
    def set_play
      @play = @scene.act.play
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scene_params
      params.require(:scene).permit(:scene_number, :summary,  :start_page, :end_page, :play_id, character_ids: [], french_scenes_attributes: [:id,  :start_page, :end_page, :french_scene_number, :_destroy, :extras_attributes, character_ids: []])
    end
end
