class SpaceAgreementsController < ApplicationController
  before_action :set_space_agreement, only: [:destroy]
	def new
		@space_agreement = SpaceAgreement.new(:theater_id => params[:theater_id])
		@theater = Theater.find(params[:theater_id])
	end

    def create
    	@space_agreement = SpaceAgreement.new(space_agreement_params)
    	respond_to do |format|
	      if @space_agreement.save
	        format.html { redirect_to @space_agreement.theater, notice: 'Space was successfully added.' }
	        format.json { render :show, status: :created, location: @space_agreement }
	      else
	        format.html { render :new }
	        format.json { render json: @space_agreement.errors, status: :unprocessable_entity }
	      end
	  end
    end
    def destroy
    @theater = Theater.find(@space_agreement.theater_id)
    @space_agreement.destroy
    respond_to do |format|
      format.html { redirect_to @theater, notice: 'Space was removed from this theater company.' }
      format.json { head :no_content }
    end
  end
private
    def set_space_agreement
      @space_agreement = SpaceAgreement.find(params[:id])
    end

	def space_agreement_params
      params.require(:space_agreement).permit(:space_id, :theater_id)
    end
end
