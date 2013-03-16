class UsersController < ApplicationController
  
  def index
  	@users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  	@polls = @user.polls.paginate(page: params[:page])
  end

end
