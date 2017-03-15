class DefaultRehearsalAttendeesController < ApplicationController
  before_action :set_default_rehearsal_attendee, only: [:show, :edit, :update, :destroy]

  # GET /default_rehearsal_attendees
  # GET /default_rehearsal_attendees.json
  def index
    @default_rehearsal_attendees = DefaultRehearsalAttendee.all
  end

  # GET /default_rehearsal_attendees/1
  # GET /default_rehearsal_attendees/1.json
  def show
  end

  # GET /default_rehearsal_attendees/new
  def new
    @default_rehearsal_attendee = DefaultRehearsalAttendee.new
  end

  # GET /default_rehearsal_attendees/1/edit
  def edit
  end

  # POST /default_rehearsal_attendees
  # POST /default_rehearsal_attendees.json
  def create
    @default_rehearsal_attendee = DefaultRehearsalAttendee.new(default_rehearsal_attendee_params)

    respond_to do |format|
      if @default_rehearsal_attendee.save
        format.html { redirect_to @default_rehearsal_attendee, notice: 'Default rehearsal attendee was successfully created.' }
        format.json { render :show, status: :created, location: @default_rehearsal_attendee }
      else
        format.html { render :new }
        format.json { render json: @default_rehearsal_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_rehearsal_attendees/1
  # PATCH/PUT /default_rehearsal_attendees/1.json
  def update
    respond_to do |format|
      if @default_rehearsal_attendee.update(default_rehearsal_attendee_params)
        format.html { redirect_to @default_rehearsal_attendee, notice: 'Default rehearsal attendee was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_rehearsal_attendee }
      else
        format.html { render :edit }
        format.json { render json: @default_rehearsal_attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_rehearsal_attendees/1
  # DELETE /default_rehearsal_attendees/1.json
  def destroy
    @default_rehearsal_attendee.destroy
    respond_to do |format|
      format.html { redirect_to default_rehearsal_attendees_url, notice: 'Default rehearsal attendee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_rehearsal_attendee
      @default_rehearsal_attendee = DefaultRehearsalAttendee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_rehearsal_attendee_params
      params.require(:default_rehearsal_attendee).permit(:rehearsal_schedule_id, :user_id)
    end
end
