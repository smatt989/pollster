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

  def random
    @completed_polls = []
    current_user.responses.each do |r|
      @completed_polls.push r.poll_id
    end
    @poll = Poll.where('id not in (?)', @completed_polls.blank? ? '' : @completed_polls)
      respond_to do |format|
        format.js
        #format.html { redirect_to poll_path(@poll) }
      end
  end


end
