class PeeragesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :set_peerage, only: [:show, :edit, :update, :destroy]

  # GET /peerages
  # GET /peerages.json
  def index
    @peerages = Peerage.all
  end

  # GET /peerages/1
  # GET /peerages/1.json
  def show
  end

  # GET /peerages/new
  def new
    @peerage = Peerage.new
  end

  # GET /peerages/1/edit
  def edit
  end

  # POST /peerages
  # POST /peerages.json
  def create
    @peerage = Peerage.new(peerage_params)

    respond_to do |format|
      if @peerage.save
        format.html { redirect_to @peerage, notice: 'Peerage was successfully created.' }
        format.json { render :show, status: :created, location: @peerage }
      else
        format.html { render :new }
        format.json { render json: @peerage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /peerages/1
  # PATCH/PUT /peerages/1.json
  def update
    respond_to do |format|
      if @peerage.update(peerage_params)
        format.html { redirect_to @peerage, notice: 'Peerage was successfully updated.' }
        format.json { render :show, status: :ok, location: @peerage }
      else
        format.html { render :edit }
        format.json { render json: @peerage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /peerages/1
  # DELETE /peerages/1.json
  def destroy
    @peerage.destroy
    respond_to do |format|
      format.html { redirect_to peerages_url, notice: 'Peerage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_peerage
      @peerage = Peerage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def peerage_params
      params.require(:peerage).permit(:description)
    end
end
