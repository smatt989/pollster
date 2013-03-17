class ResponsesController < ApplicationController
  def new
  end
  
  def create
    @response = current_user.responses.build(params[:response])
    if @response.save
      flash[:success] = "response created!"
      respond_to do |format|
        format.js
        format.html { redirect_to root_path }
      end
    else
      flash[:error] = "failed to create response"
      render '/'
    end

  end

  def show
  	@response = Response.find(params[:id])
  	@user = User.find_by_id(@response.user_id)
  end

end
