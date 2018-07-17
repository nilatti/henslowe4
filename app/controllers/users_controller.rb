class UsersController < ApplicationController
	load_and_authorize_resource

	def index
    @users = User.all
  end

  def show
  end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@generated_password = "ThisIsATemporaryPassword" #Devise.friendly_token.first(8)
		@user.password = @generated_password
		@user.password_confirmation = @generated_password

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @author }
        #UserMailer.welcome_email(@user, @generated_password).deliver
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
		respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { respond_with_bip(@user) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@user) }
      end
    end
	end

	def destroy

    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to dashboard_index_path
    end
  end

  def resend_invite
    @user.invite!
    flash[:notice] = "Resent invitation to #{@user.try(:name)}"
    redirect_to dashboard_index_path
  end


private

	def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end
end
