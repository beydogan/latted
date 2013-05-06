class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  private

  def render(*args)
    options = args.extract_options!
    options[:template] = "/users/#{params[:action]}"
    super(*(args << options))
  end
end
