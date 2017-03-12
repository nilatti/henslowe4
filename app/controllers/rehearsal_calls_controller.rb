class RehearsalCallsController < ApplicationController
  before_action :set_rehearsal_call, only: [:show, :edit, :update, :destroy]

  # GET /rehearsal_calls
  # GET /rehearsal_calls.json
  def index
    @rehearsal_calls = RehearsalCall.all
  end

  # GET /rehearsal_calls/1
  # GET /rehearsal_calls/1.json
  def show
  end

  # GET /rehearsal_calls/new
  def new
    @rehearsal_call = RehearsalCall.new
  end

  # GET /rehearsal_calls/1/edit
  def edit
  end

  # POST /rehearsal_calls
  # POST /rehearsal_calls.json
  def create
    @rehearsal_call = RehearsalCall.new(rehearsal_call_params)

    respond_to do |format|
      if @rehearsal_call.save
        format.html { redirect_to @rehearsal_call, notice: 'Rehearsal call was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal_call }
      else
        format.html { render :new }
        format.json { render json: @rehearsal_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rehearsal_calls/1
  # PATCH/PUT /rehearsal_calls/1.json
  def update
    respond_to do |format|
      if @rehearsal_call.update(rehearsal_call_params)
        format.html { redirect_to @rehearsal_call, notice: 'Rehearsal call was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal_call }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rehearsal_calls/1
  # DELETE /rehearsal_calls/1.json
  def destroy
    @rehearsal_call.destroy
    respond_to do |format|
      format.html { redirect_to rehearsal_calls_url, notice: 'Rehearsal call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rehearsal_call
      @rehearsal_call = RehearsalCall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rehearsal_call_params
      params.require(:rehearsal_call).permit(:rehearsal_id, :user_id)
    end
end
