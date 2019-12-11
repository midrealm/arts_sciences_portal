class JudgeFairsController < ApplicationController
  before_action :set_judge_fair, only: [:show, :edit, :update, :destroy]

  # GET /judge_fairs
  # GET /judge_fairs.json
  def index
    if current_user.admin?
      @judge_fairs = JudgeFair.all
    else
      @judge_fairs = JudgeFair.for_user(current_user)
    end
  end

    # GET /judge_fairs/new
    def new
      @judge_fair = JudgeFair.new
    end

    # POST /judge_fairs
    # POST /judge_fairs.json
    def create
      @judge_fair = JudgeFair.new(judge_fair_params)

      respond_to do |format|
        if @judge_fair.save
          format.html { redirect_to judge_fairs_path, notice: 'Judge fair was successfully created.' }
          format.json { render :show, status: :created, location: @judge_fair }
        else
          format.html { render :new }
          format.json { render json: @judge_fair.errors, status: :unprocessable_entity }
        end
      end
    end


    # DELETE /judge_fairs/1
    # DELETE /judge_fairs/1.json
    def destroy
      @judge_fair.destroy
      respond_to do |format|
        format.html { redirect_to judge_fairs_url, notice: 'Judge fair was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_judge_fair
      @judge_fair = JudgeFair.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def judge_fair_params
      params.require(:judge_fair).permit(:fair_id).merge(user_id: current_user.id)
    end
  end
