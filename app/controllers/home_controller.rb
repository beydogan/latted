class HomeController < ApplicationController
  layout "wide_layout"

  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end
end
