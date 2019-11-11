class ScoresheetsController < ApplicationController
  before_action :set_scoresheet, only: [:show, :edit, :update, :destroy]

  # GET /scoresheets
  # GET /scoresheets.json
  def index
    @scoresheets = Scoresheet.all
  end

  # GET /scoresheets/1
  # GET /scoresheets/1.json
  def show
  end

  # GET /scoresheets/new
  def new
    @scoresheet = Scoresheet.new
  end

  # GET /scoresheets/1/edit
  def edit
  end

  # POST /scoresheets
  # POST /scoresheets.json
  def create
    @scoresheet = Scoresheet.new(scoresheet_params)

    respond_to do |format|
      if @scoresheet.save
        format.html { redirect_to @scoresheet, notice: 'Scoresheet was successfully created.' }
        format.json { render :show, status: :created, location: @scoresheet }
      else
        format.html { render :new }
        format.json { render json: @scoresheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scoresheets/1
  # PATCH/PUT /scoresheets/1.json
  def update
    respond_to do |format|
      if @scoresheet.update(scoresheet_params)
        format.html { redirect_to @scoresheet, notice: 'Scoresheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @scoresheet }
      else
        format.html { render :edit }
        format.json { render json: @scoresheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scoresheets/1
  # DELETE /scoresheets/1.json
  def destroy
    @scoresheet.destroy
    respond_to do |format|
      format.html { redirect_to scoresheets_url, notice: 'Scoresheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scoresheet
      @scoresheet = Scoresheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scoresheet_params
      params.require(:scoresheet).permit(:score_id, :user_id, :entry_id)
    end
end
