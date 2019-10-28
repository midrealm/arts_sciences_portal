class CriteriaDescriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :set_criteria_description, only: [:show, :edit, :update, :destroy]

  # GET /criteria_descriptions
  # GET /criteria_descriptions.json
  def index
    @criteria_descriptions = CriteriaDescription.all
  end

  # GET /criteria_descriptions/1
  # GET /criteria_descriptions/1.json
  def show
  end

  # GET /criteria_descriptions/new
  def new
    @criteria_description = CriteriaDescription.new
  end

  # GET /criteria_descriptions/1/edit
  def edit
  end

  # POST /criteria_descriptions
  # POST /criteria_descriptions.json
  def create
    @criteria_description = CriteriaDescription.new(criteria_description_params)

    respond_to do |format|
      if @criteria_description.save
        format.html { redirect_to @criteria_description, notice: 'Criteria description was successfully created.' }
        format.json { render :show, status: :created, location: @criteria_description }
      else
        format.html { render :new }
        format.json { render json: @criteria_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria_descriptions/1
  # PATCH/PUT /criteria_descriptions/1.json
  def update
    respond_to do |format|
      if @criteria_description.update(criteria_description_params)
        format.html { redirect_to @criteria_description, notice: 'Criteria description was successfully updated.' }
        format.json { render :show, status: :ok, location: @criteria_description }
      else
        format.html { render :edit }
        format.json { render json: @criteria_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria_descriptions/1
  # DELETE /criteria_descriptions/1.json
  def destroy
    @criteria_description.destroy
    respond_to do |format|
      format.html { redirect_to criteria_descriptions_url, notice: 'Criteria description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criteria_description
      @criteria_description = CriteriaDescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criteria_description_params
      params.require(:criteria_description).permit(:description, :category_id, :criteria_type_id)
    end
end
