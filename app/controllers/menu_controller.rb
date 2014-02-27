class MenuController < ApplicationController
  # GET /menu
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
