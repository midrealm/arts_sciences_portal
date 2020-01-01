class UserEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_entry, only: [:show, :edit, :destroy]
  before_action :set_entry
  before_action :verify_user_entry

  def verify_user_entry
    authorize @entry, :owns_entry?
  end

  # GET /user_entries
  # GET /user_entries.json
  def index
    @user_entries = UserEntry.where(entry_id: @entry.id).reject{|record| record.user_id == current_user.id}
  end

  # GET /user_entries/1
  # GET /user_entries/1.json
  # def show
  # end

  # GET /user_entries/new
  def new
    @user_entry = UserEntry.new
  end

  # GET /user_entries/1/edit
  # def edit
  # end

  # POST /user_entries
  # POST /user_entries.json
  def create
    @user_entry = UserEntry.new(user_entry_params)

    respond_to do |format|
      if @user_entry.save
        format.html { redirect_to entry_user_entries_url, notice: 'Judge preference was successfully created.' }
        format.json { render :show, status: :created, location: @user_entry }
      else
        format.html { render :new }
        format.json { render json: @user_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_entries/1
  # PATCH/PUT /user_entries/1.json
  # def update
  #   respond_to do |format|
  #     if @user_entry.update(user_entry_params)
  #       format.html { redirect_to @user_entry, notice: 'Judge preference was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user_entry }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user_entry.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /user_entries/1
  # DELETE /user_entries/1.json
  def destroy
    @user_entries = UserEntry.all
    @user_entry.destroy
    respond_to do |format|
      format.html { redirect_to entry_user_entries_url, notice: 'Judge preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_entry
      @user_entry = UserEntry.find(params[:id])
    end

  def set_entry
    @entry = Entry.find(params[:entry_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_entry_params
      params.require(:user_entry).require(:user_entries).permit(:user_id).merge({entry_id: @entry.id})
    end
end
