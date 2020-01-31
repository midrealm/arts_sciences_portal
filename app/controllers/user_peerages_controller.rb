class UserPeeragesController < ApplicationController
  before_action :set_user_peerage, only: [:show, :edit, :update, :destroy]

  # GET /user_peerages
  # GET /user_peerages.json
  def index
    @user_peerages = UserPeerage.all
  end

  # GET /user_peerages/1
  # GET /user_peerages/1.json
  def show
  end

  # GET /user_peerages/new
  def new
    @user_peerage = UserPeerage.new
  end

  # GET /user_peerages/1/edit
  def edit
  end

  # POST /user_peerages
  # POST /user_peerages.json
  def create
    @user_peerage = UserPeerage.new(user_peerage_params)

    respond_to do |format|
      if @user_peerage.save
        format.html { redirect_to @user_peerage, notice: 'User peerage was successfully created.' }
        format.json { render :show, status: :created, location: @user_peerage }
      else
        format.html { render :new }
        format.json { render json: @user_peerage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_peerages/1
  # PATCH/PUT /user_peerages/1.json
  def update
    respond_to do |format|
      if @user_peerage.update(user_peerage_params)
        format.html { redirect_to @user_peerage, notice: 'User peerage was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_peerage }
      else
        format.html { render :edit }
        format.json { render json: @user_peerage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_peerages/1
  # DELETE /user_peerages/1.json
  def destroy
    @user_peerage.destroy
    respond_to do |format|
      format.html { redirect_to user_peerages_url, notice: 'User peerage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_peerage
      @user_peerage = UserPeerage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_peerage_params
      params.require(:user_peerage).permit(:user_id, :peerage_id)
    end
end
