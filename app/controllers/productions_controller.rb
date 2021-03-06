class ProductionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_production, only: [:show, :edit, :update, :destroy, :edit_casting, :doubling]
  before_action :set_theater
  before_action :set_play

  # GET /productions
  # GET /productions.json
  def index
    @productions = Production.where("theater_id = #{@theater.id}")
  end

  # GET /productions/1
  # GET /productions/1.json
  def show
  end

  def doubling
    @french_scenes = Play.includes(:french_scenes).find(@production.play.id).french_scenes.sort { |a, b| a.pretty_name <=> b.pretty_name }
    # @play = Play.includes(acts: { scenes: { french_scenes: :on_stages}}).find(@production.play.id)
    @actors = @production.actors
  end

  def who_is_in_and_out
  end
  # GET /productions/new
  def new
    @production = Production.new
  end

  # GET /productions/1/edit
  def edit
  end

  # POST /productions
  # POST /productions.json
  def create
    @orig_play = Play.find(production_params[:play_id])
    @production = @theater.productions.build(production_params)

    @dup_play = RailsDeepCopy::Duplicate.create(@orig_play, changes: { canonical: false, production_id: @production.id })

    @production.play = @dup_play
    @production.play.characters.each do |character|
      @production.jobs.build(:character_id => character.id, :specialization_id => 2, :theater_id => @production.theater.id, :start_date => @production.start_date, :end_date => @production.end_date) # THIS VALUE FOR ACTOR IS HARD CODED AND THAT IS BAD. In current instance, Specialization.find(2) = Actor. How can I make this dynamic without querying it constantly?
    end

    respond_to do |format|
      if @production.save
        format.html { redirect_to @production, notice: 'Production was successfully created.' }
        format.json { render :show, status: :created, location: @production }
      else
        format.html { render :new }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productions/1
  # PATCH/PUT /productions/1.json
  def update
    respond_to do |format|
      if @production.update(production_params)
        format.html { redirect_to @production, notice: 'Production was successfully updated.' }
        format.json { respond_with_bip(@production) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@production) }
      end
    end
  end

  # DELETE /productions/1
  # DELETE /productions/1.json
  def destroy
    @production.destroy
    respond_to do |format|
      format.html { redirect_to theater_path(@production.theater), notice: 'Production was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_casting
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production
      @production = Production.includes(:play, :users).find(params[:id])
    end

    def set_theater
      if params[:theater_id]
        @theater = Theater.find(params[:theater_id])
      end
    end

    def set_play
      if params[:play_id]
        @play = Play.find(params[:play_id])
      elsif @production.play
        @play = Play.find(@production.play.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_params
      params.require(:production).permit(:start_date, :end_date, :play_id, :theater_id, jobs_attributes: [:id, :production_id, :specialization_id, :user_id, :theater_id, :character_id])
    end
end
