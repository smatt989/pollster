class UsersController < ApplicationController
  before_filter :signed_in_user  
  def index
  	@users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  	@polls = @user.polls.paginate(page: params[:page])
  end

end
