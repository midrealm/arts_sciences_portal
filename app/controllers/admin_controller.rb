class AdminController < ApplicationController
  before_action :authenticate_user!

  # GET /
  def index
  end
end
