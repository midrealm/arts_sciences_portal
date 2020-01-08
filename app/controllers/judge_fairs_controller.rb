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

  # GET /judge_assigns/1/edit
  def edit
  end

  # POST /judge_fairs
  # POST /judge_fairs.json
  def create
    @judge_fair = JudgeFair.new(judge_fair_params)

    respond_to do |format|
      if @judge_fair.save
        format.html { redirect_to judge_fairs_path, notice: 'Successfully volunteered.' }
        format.json { render :show, status: :created, location: @judge_fair }
      else
        format.html { render :new }
        format.json { render json: @judge_fair.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @judge_fair.update(judge_fair_params)
        format.html { redirect_to judge_fairs_path, notice: 'Successfully updated volunteer details.' }
        format.json { render :show, status: :ok, location: @judge_fair }
      else
        format.html { render :edit }
        format.json { render json: @judge_fairs.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /judge_fairs/1
  # DELETE /judge_fairs/1.json
  def destroy
    @judge_fair.destroy
    respond_to do |format|
      format.html { redirect_to judge_fairs_url, notice: 'Successfully removed volunteer.' }
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
    params.require(:judge_fair).permit(:fair_id, :shadow_judge).merge(user_id: current_user.id)
  end
end
