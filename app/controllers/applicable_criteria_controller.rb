class ApplicableCriteriaController < ApplicationController
  before_action :set_applicable_criterium, only: [:show, :edit, :update, :destroy]

  # GET /applicable_criteria
  # GET /applicable_criteria.json
  def index
    @applicable_criteria = ApplicableCriterium.all
  end

  # GET /applicable_criteria/1
  # GET /applicable_criteria/1.json
  def show
  end

  # GET /applicable_criteria/new
  def new
    @applicable_criterium = ApplicableCriterium.new
  end

  # GET /applicable_criteria/1/edit
  def edit
  end

  # POST /applicable_criteria
  # POST /applicable_criteria.json
  def create
    @applicable_criterium = ApplicableCriterium.new(applicable_criterium_params)

    respond_to do |format|
      if @applicable_criterium.save
        format.html { redirect_to @applicable_criterium, notice: 'Applicable criterium was successfully created.' }
        format.json { render :show, status: :created, location: @applicable_criterium }
      else
        format.html { render :new }
        format.json { render json: @applicable_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicable_criteria/1
  # PATCH/PUT /applicable_criteria/1.json
  def update
    respond_to do |format|
      if @applicable_criterium.update(applicable_criterium_params)
        format.html { redirect_to @applicable_criterium, notice: 'Applicable criterium was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicable_criterium }
      else
        format.html { render :edit }
        format.json { render json: @applicable_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicable_criteria/1
  # DELETE /applicable_criteria/1.json
  def destroy
    @applicable_criterium.destroy
    respond_to do |format|
      format.html { redirect_to applicable_criteria_url, notice: 'Applicable criterium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicable_criterium
      @applicable_criterium = ApplicableCriterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicable_criterium_params
      params.require(:applicable_criterium).permit(:category_id, :criteria_type_id)
    end
end
