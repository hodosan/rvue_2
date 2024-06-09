class RegulationsController < ApplicationController
  before_action :set_regulation, only: %i[ show edit update destroy ]

  # GET /regulations or /regulations.json
  def index
    @regulation = Regulation.last 
  end

  # GET /regulations/1 or /regulations/1.json
  def show
  end

  # GET /regulations/new
  def new
    @regulation = Regulation.new
  end

  # GET /regulations/1/edit
  def edit
  end

  # POST /regulations or /regulations.json
  def create
    @regulation = Regulation.new(regulation_params)

    respond_to do |format|
      if @regulation.save
        format.html { redirect_to regulation_url(@regulation), notice: "Regulation was successfully created." }
        format.json { render :show, status: :created, location: @regulation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @regulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regulations/1 or /regulations/1.json
  def update
    respond_to do |format|
      if @regulation.update(regulation_params)
        format.html { redirect_to regulation_url(@regulation), notice: "Regulation was successfully updated." }
        format.json { render :show, status: :ok, location: @regulation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @regulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regulations/1 or /regulations/1.json
  def destroy
    @regulation.destroy!

    respond_to do |format|
      format.html { redirect_to regulations_url, notice: "Regulation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regulation
      @regulation = Regulation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def regulation_params
      params.require(:regulation).permit(:begin_time, :close_time, :interval_s, :interval_e, :unit_minute, :version)
    end
end
