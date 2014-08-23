class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all.in_groups_of(4) 
	end

	def new
		@user = User.new(team_params)

		respond_to do |format|
		  if @user.save
		    format.html { redirect_to @user, notice: 'User was successfully created.' }
		    format.json { render :show, status: :created, location: @user }
		  else
		    format.html { render :new }
		    format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
		
	end

	def show
	end

	def edit
	end

	def update
		respond_to do |format|
		  if @user.update(user_params)
		    format.html { redirect_to @user, notice: 'User was successfully updated.' }
		    format.json { render :show, status: :ok, location: @user }
		  else
		    format.html { render :edit }
		    format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end

	def destroy
	  @user.destroy
	  respond_to do |format|
	    format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
	    format.json { head :no_content }
	  end
	end

	private
    	# Use callbacks to share common setup or constraints between actions.
	    def set_user
	      @user = User.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def user_params
	      params.require(:user).permit(:name, :employee_no ,:date_of_birth,:nrc_number, :bank_card_number, :nationality, :religion,:gender, :phone_no, :blood_type,  :joined_date,  :left_date, :address, :email)
	    end
end
