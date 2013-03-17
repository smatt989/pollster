class PollsController < ApplicationController
  def new
  end

  def create
    @poll = current_user.polls.build(params[:poll])
    if @poll.save
      flash[:success] = "poll created!"
      redirect_to root_url
    else
      flash[:error] = "failed to create poll"
      render '/'
    end
  end

  def index
  	@polls = Poll.paginate(page: params[:page])
  end

  def show
  	@poll = Poll.find(params[:id])
  end

end
