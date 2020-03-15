include FairsHelper

class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy, :promote]
  before_action :verify_user_entry, only: [:show, :edit, :update, :destroy, :promote]
  before_action :verify_entry_editable, only: [:edit, :update, :destroy]
  before_action :verify_promotable, only: [:promote]

  def verify_user_entry
    authorize @entry, :owns_entry?
  end

  def verify_entry_editable
    authorize @entry, :entry_open?
  end

  def verify_promotable
    authorize @entry, :promotable?
  end

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.user_entries(current_user).order(:fair_id, :entry_name)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        UserEntry.create!(user_id: current_user.id, entry_id: @entry.id)
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def promote
    entrants = @entry.users

    new_entry = @entry.dup
    new_entry.fair_id = next_kingdom_fair.id
    new_entry.save

    entrants.each do |user|
      UserEntry.create(entry_id: new_entry.id, user_id: user.id)
    end

    @entry.prior_entry_id = new_entry.id

    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully promoted to Kingdom.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(
        :entry_name,
        :description,
        :category_id,
        :in_person,
        :scored,
        :materials,
        :culture,
        :time_period,
        :pentathlon,
        :division,
        :first_time,
        :youth,
        :fair_id
      )
    end
end
