class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  before_action :set_theater

  def index
    if @theater
      @spaces = Space.where("theater_id = #{@theater.id}")
    else
      @spaces = Space.all
    end
  end

  def show
  end

  def new
    @space = Space.new
  end

  def edit
  end

  def create
    @space = Space.create(space_params)


    respond_to do |format|
      if @space.save
        format.html { redirect_to @space, notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to @space, notice: 'Space was successfully updated.' }
        format.json { respond_with_bip(@space) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@space) }
      end
    end
  end

  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_space
      @space = Space.find(params[:id])
    end

    def set_theater
      if params[:theater_id]
        @theater = Theater.find(params[:theater_id])
      end
    end

    def space_params
      params.require(:space).permit(:name, :street_address, :city, :state, :zip, :phone_number, :website, :seating_capacity, :calendar, :theater_id)
    end
end
