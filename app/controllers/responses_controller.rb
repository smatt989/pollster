class ResponsesController < ApplicationController
  def new
  end
  
  def create
    @response = current_user.responses.build(params[:response])
    if @response.save
      flash[:success] = "response created!"
      redirect_to root_url
    else
      flash[:error] = "failed to create response"
      render '/'
    end
  end

  def show
  	@response = response.find(params[:id])
  	@user = User.find_by_id(@response.user_id)
  end

end
