class LeaveApplicationsController < ApplicationController
  before_action :set_leave_application, only: [:show, :edit, :update, :destroy]

  # GET /leave_applications
  # GET /leave_applications.json
  def index
    @leave_applications = LeaveApplication.page(params[:page])
  end

  # GET /leave_applications/1
  # GET /leave_applications/1.json
  def show
  end

  # GET /leave_applications/new
  def new
    @leave_application = LeaveApplication.new
  end

  # GET /leave_applications/1/edit
  def edit
  end

  # POST /leave_applications
  # POST /leave_applications.json
  def create
    @leave_application = LeaveApplication.new(leave_application_params)
    respond_to do |format|
      if @leave_application.save!
        format.html { redirect_to @leave_application, notice: 'Leave application was successfully created.' }
        format.json { render :show, status: :created, location: @leave_application }
      else
        format.html { render :new }
        format.json { render json: @leave_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leave_applications/1
  # PATCH/PUT /leave_applications/1.json
  def update
    respond_to do |format|
      if @leave_application.update(leave_application_params)
        format.html { redirect_to @leave_application, notice: 'Leave application was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave_application }
      else
        format.html { render :edit }
        format.json { render json: @leave_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leave_applications/1
  # DELETE /leave_applications/1.json
  def destroy
    @leave_application.destroy
    respond_to do |format|
      format.html { redirect_to leave_applications_url, notice: 'Leave application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_application
      @leave_application = LeaveApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_application_params
      params.require(:leave_application).permit(:application_date, :reason,:user_id, leave_dates_attributes: [:id,:date,:leave_period_id,:_destroy])
    end
end
