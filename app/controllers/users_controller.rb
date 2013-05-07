class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @me = (current_user.id == @user.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def follow
    current_user.follow!(params["id"]);
    respond_to do |format|
      format.js
    end
    end

  def unfollow
    current_user.unfollow!(params["id"]);
    respond_to do |format|
      format.js
    end
  end

  private

  def render(*args)
    options = args.extract_options!
    options[:template] = "/users/#{params[:action]}"
    super(*(args << options))
  end
end
