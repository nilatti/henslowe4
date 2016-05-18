class ActsController < ApplicationController
  load_and_authorize_resource :play
  load_and_authorize_resource :act, :through => :play, :shallow => true
  before_action :set_act, only: [:show, :edit, :update, :destroy]
  before_action :set_play

  # GET /acts
  # GET /acts.json
  def index
    @acts = Act.where("play_id = #{@play.id}")
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
    acts = @act.play.acts
    acts = acts.sort { |a, b| a.act_number <=> b.act_number }
    index = acts.index { |a| a.id == @act.id }
    
    @next = acts[index + 1]
    if index > 0
      @previous = acts[index-1]
    end
  end

  # GET /acts/new
  def new
    @act = Act.new
  end

  # GET /acts/1/edit
  def edit
  end

  # POST /acts
  # POST /acts.json
  def create
    @act = @play.acts.build(act_params)

    respond_to do |format|
      if @act.save
        format.html { redirect_to @act.play, notice: 'Act was successfully created.' }
        format.json { render :show, status: :created, location: @act }
      else
        format.html { render :new }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    respond_to do |format|
      if @act.update(act_params)
        format.html { redirect_to @act.play, notice: 'Act was successfully updated.' }
        format.json { respond_with_bip(@act) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@act) }
      end
    end
  end

  # DELETE /acts/1
  # DELETE /acts/1.json
  def destroy
    @act.destroy
    respond_to do |format|
      format.html { redirect_to @play, notice: 'Act was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_act
      @act = Act.find(params[:id])
    end

    def set_play
      if params[:play_id]
        @play = Play.find(params[:play_id])
      else
        @play = Play.find(@act.play.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def act_params
      params.require(:act).permit(:act_number, :summary, :start_page, :end_page, :play_id, scenes_attributes: [:id, :scene_number,  :start_page, :end_page, :summary, :_destroy, french_scenes_attributes: [:id, :french_scene_number,  :start_page, :end_page, :_destroy, character_ids: []]])
    end
end
