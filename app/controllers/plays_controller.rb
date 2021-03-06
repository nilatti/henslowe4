class PlaysController < ApplicationController
  load_and_authorize_resource
  before_action :set_play, only: %i[show edit update destroy]
  before_action :set_author
  # GET /plays
  # GET /plays.json
  def index
    @plays = if @author
               Play.where("author_id = #{@author.id}")
             else
               Play.all
             end
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
    @production = Production.find(@play.production_id) if @play.production_id
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # GET /plays/1/edit
  def edit
    @production = Production.find(@play.production_id) if @play.production_id
  end

  # POST /plays
  # POST /plays.json
  def create
    @play = @author.plays.build(play_params)

    respond_to do |format|
      if @play.save
        format.html { redirect_to play_path(@play), notice: 'Play was successfully created.' }
        format.json { render :show, status: :created, location: @play }
      else
        format.html { render :new }
        format.json { render json: @play.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to play_path(@play), notice: 'Play was successfully updated.' }
        format.json { respond_with_bip(@play) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@play) }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.json
  def destroy
    @author = @play.author_id
    @play.destroy
    respond_to do |format|
      format.html { redirect_to author_plays_url(@author), notice: 'Play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_play
    @play = Play.find(params[:id])
  end

  def set_author
    @author = Author.find(params[:author_id]) if params[:author_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def play_params
    params.require(:play).permit(:title, :date, :author_id, :canonical, :summary, :text_notes, :script, :start_page, :end_page, characters_attributes: %i[id name age gender _destroy], acts_attributes: [:id, :act_number, :summary, :start_page, :end_page, :_destroy, scenes_attributes: [:id, :scene_number, :start_page, :end_page, :summary, :_destroy, french_scenes_attributes: [:id, :french_scene_number, :start_page, :end_page, :_destroy, character_ids: []]]])
  end
end
