class LinesController < ApplicationController
  before_action :set_line, only: %i[show edit update destroy]
  before_action :set_play, only: [:edit]

  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all
  end

  # GET /lines/1
  # GET /lines/1.json
  def show; end

  # GET /lines/new
  def new
    @french_scene = FrenchScene.find(params[:french_scene_id])
    @line = @french_scene.lines.build
    @play = @line.french_scene.scene.act.play
  end

  # GET /lines/1/edit
  def edit; end

  # POST /lines
  # POST /lines.json
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: 'Line was successfully created.' }
        format.json { render :show, status: :created, location: @line }
      else
        format.html { render :new }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { render :show, status: :ok, location: @line }
      else
        format.html { render :edit }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    french_scene = @line.french_scene
    @line.destroy
    respond_to do |format|
      format.html { redirect_to french_scene_url(french_scene), notice: 'Line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line
    @line = Line.find(params[:id])
  end

  def set_play
    @play = @line.french_scene.scene.act.play
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_params
    params.require(:line).permit(:category, :character_id, :cut, :french_scene_id, :line_number, :text)
  end
end
