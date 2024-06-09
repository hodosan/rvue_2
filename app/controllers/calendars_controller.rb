class CalendarsController < ApplicationController
  before_action :set_calendar, only: %i[ show edit update destroy ]
  include CalendarData

  # GET /calendars or /calendars.json
  def index
    @calendars = Calendar.all   
    month = params[:month]
    calendar_for_view(month)
    
    regulation    = Regulation.last
    @begin_time   = regulation.begin_time
    @close_time   = regulation.close_time
    @interval_s   = regulation.interval_s
    @interval_e   = regulation.interval_e
    @unit_minute  = regulation.unit_minute

  end

  # GET /calendars/1 or /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
    @calendar.day         = params[:day] 
    @calendar.begin_time  = params[:day] + 'T' + params[:begin_time]
    @calendar.close_time  = params[:day] + 'T' + params[:close_time]
    @calendar.interval_s  = params[:day] + 'T' + params[:interval_s]
    @calendar.interval_e  = params[:day] + 'T' + params[:interval_e]
    @calendar.unit_minute = params[:unit_minute]
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars or /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar was successfully created." }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1 or /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar was successfully updated." }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1 or /calendars/1.json
  def destroy
    @calendar.destroy!

    respond_to do |format|
      format.html { redirect_to calendars_url, notice: "Calendar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calendar_params
      params.require(:calendar).permit(:day, :begin_time, :close_time, :interval_s, :interval_e, :unit_minute, :no_use)
    end
end