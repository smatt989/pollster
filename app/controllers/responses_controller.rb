class ResponsesController < ApplicationController

  before_filter :signed_in_user

  def new
  end
  
  def create
  	responded = Response.where(:poll_id => params[:response][:poll_id], :user_id => current_user.id)
  	if(responded.blank?) #checks if user has been to this poll or not
      @response = current_user.responses.build(params[:response])
      if @response.save
        flash[:success] = "response created!"
        respond_to do |format|
          format.html { redirect_to analytics_poll_path( :id => @response.poll_id, :format => :html) }
          format.json { redirect_to analytics_poll_path( :id => @response.poll_id, :format => :json ) }
        end
      else
        flash[:error] = "failed to create response"
        respond_to do |format|
          format.html { redirect_to root_path }
          format.json { render :json => @response.errors.full_messages.to_json }
        end
      end
    else
      respond_to do |format|
      	format.html { redirect_to root_path }
      	format.json { render :json => { responded: "double_response" } }
      end
    end

  end

  def show
  	@response = Response.find(params[:id])
  	@user = User.find_by_id(@response.user_id)
  end


end
