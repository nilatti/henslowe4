class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]
  before_action :set_author

  # GET /plays
  # GET /plays.json
  def index
    if @author
      @plays = Play.where("author_id = #{@author.id}")
    else 
      @plays = Play.all
    end
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # GET /plays/1/edit
  def edit

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
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit }
        format.json { render json: @play.errors, status: :unprocessable_entity }
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
      if params[:author_id]
        @author = Author.find(params[:author_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params.require(:play).permit(:title, :date, :author_id, acts_attributes: [:id, :act_number, :_destroy, scenes_attributes: [:id, :scene_number, :_destroy, french_scenes_attributes: [:id, :french_scene_number, :_destroy]]])
    end
end
