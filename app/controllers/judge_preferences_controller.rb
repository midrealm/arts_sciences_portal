class JudgePreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_judge_preference, only: [:show, :edit]
  before_action :set_user
  before_action :verify_user_preference

  def verify_user_preference
    authorize params[:user_id], :owns_preference?, policy_class: JudgePreferencePolicy
  end

  # GET /judge_preferences
  # GET /judge_preferences.json
  def index
    @judge_preferences = JudgePreference.all
  end

  # GET /judge_preferences/1
  # GET /judge_preferences/1.json
  # def show
  # end

  # GET /judge_preferences/new
  def new
    @judge_preference = JudgePreference.new
  end

  # GET /judge_preferences/1/edit
  # def edit
  # end

  # POST /judge_preferences
  # POST /judge_preferences.json
  def create
    selected_categories = params[:user][:selected_categories].drop(1)
    #destroy all unselected categories
    current_user.selected_categories.each do |category_id|
      JudgePreference.find_by(user_id: current_user.id, category_id: category_id).destroy unless selected_categories.include?(category_id.to_s)
    end

    selected_categories.each do |category_id|
      JudgePreference.find_or_create_by({user_id: current_user.id, category_id: category_id})
    end

    respond_to do |format|
      format.html { redirect_to user_judge_preferences_url, notice: 'Judge preference was successfully created.' }
      format.json { render :show, status: :created, location: @judge_preference }
    end
  end

  # PATCH/PUT /judge_preferences/1
  # PATCH/PUT /judge_preferences/1.json
  # def update
  #   respond_to do |format|
  #     if @judge_preference.update(judge_preference_params)
  #       format.html { redirect_to @judge_preference, notice: 'Judge preference was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @judge_preference }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @judge_preference.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /judge_preferences/1
  # DELETE /judge_preferences/1.json
  # def destroy
  #   @judge_preferences = JudgePreference.all
  #   @judge_preference.destroy
  #   respond_to do |format|
  #     format.html { redirect_to user_judge_preferences_url, notice: 'Judge preference was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_judge_preference
      @judge_preference = JudgePreference.find(params[:id])
    end

  def set_user
    @user = current_user
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def judge_preference_params
      params.require(:judge_preference).require(:judge_preferences).permit(:category_id).merge({user_id: @current_user.id})
    end
end
