class SessionsController < ApplicationController
  include SessionsHelper

  def create
  	auth = request.env["omniauth.auth"]
  	@user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  	#session[:user_id] = @user.uid
    sign_in @user
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: @user.as_json(:only => [:name]) }
    end
  end

  def destroy
  	sign_out
  	redirect_to root_url, :notice => "Signed out!"
  end

  
end
