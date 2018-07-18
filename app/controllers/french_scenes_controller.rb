class FrenchScenesController < ApplicationController
  load_and_authorize_resource :scene
  load_and_authorize_resource :french_scene, :through => :scene, :shallow => true

  before_action :set_french_scene, only: [:show, :edit, :update, :destroy]
  before_action :set_scene
  before_action :set_play, only: [:edit]

  # GET /french_scenes
  # GET /french_scenes.json
  def index
    @french_scenes = FrenchScene.where("scene_id = #{@scene.id}")
  end

  # GET /french_scenes/1
  # GET /french_scenes/1.json
  def show
    french_scenes = @french_scene.scene.act.play.french_scenes
    french_scenes = french_scenes.sort { |a, b| a.pretty_name <=> b.pretty_name }
    index = french_scenes.index { |fs| fs.id == @french_scene.id }

    @next = french_scenes[index + 1]
    if index > 0
      @previous = french_scenes[index-1]
    end
  end

  # GET /french_scenes/new
  def new
    @french_scene = FrenchScene.new
  end

  # GET /french_scenes/1/edit
  def edit
    @production = Production.find_by(:play_id == @play.id)
    @users = @production.involved_users
  end

  # POST /french_scenes
  # POST /french_scenes.json
  def create
    @french_scene = @scene.french_scenes.build(french_scene_params)

    respond_to do |format|
      if @french_scene.save
        format.html { redirect_to @french_scene.scene, notice: 'French scene was successfully created.' }
        format.json { render :show, status: :created, location: @french_scene }
      else
        format.html { render :new }
        format.json { render json: @french_scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /french_scenes/1
  # PATCH/PUT /french_scenes/1.json
  def update
    respond_to do |format|
      if @french_scene.update(french_scene_params)
        format.html { redirect_to @french_scene, notice: 'French scene was successfully updated.' }
        format.json { respond_with_bip(@french_scene) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@french_scene) }
      end
    end
  end

  # DELETE /french_scenes/1
  # DELETE /french_scenes/1.json
  def destroy
    @french_scene.destroy
    respond_to do |format|
      format.html { redirect_to french_scenes_url, notice: 'French scene was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_french_scene
      @french_scene = FrenchScene.find(params[:id])
    end

    def set_scene
      if params[:scene_id]
        @scene = Scene.find(params[:scene_id])
      end
    end

    def set_play
      @play = Play.find(@french_scene.scene.act.play)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def french_scene_params
      params.require(:french_scene)
      .permit(
        :end_page,
        :french_scene_number,
        :scene_id,
        :start_page,
        character_ids: [],
        extras_attributes: [:id, :french_scene_id, :name, :needs_costume, :user_id, :_destroy],
        on_stages_attributes: [:id, :necessary, :_destroy]
      )
    end
end
