class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :verify_admin, only: [:index, :destroy]
  before_action :verify_user, only: [:show, :edit, :update]

  def verify_user
    authorize @user, :correct_user?
  end

  # GET /user
  def index
    @users = User.all
  end

  # GET /user
  def show
  end

  # GET /user/1/edit
  def edit
  end

  # PATCH/PUT /user/1
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

  # DELETE /user/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to user_url, notice: 'User was successfully destroyed.' }
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
      params.require(:user).permit(:region_id, :written, :first_time, :user_role_id, :name, :sca_name)
    end
end
