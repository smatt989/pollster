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
    @poll = Poll.find(:first, :conditions => ['id not in (?)', @completed_polls.blank? ? '' : @completed_polls] ) 
     redirect_to poll_path(@poll)
  end
  
  def analytics
    @poll = Poll.find(params[:id])
    @all_responses = []
    @poll.responses.each do |r|
      @all_responses.push r
    end
    @responses1 = []
    @responses2 = []
    if(@poll.answer_3.blank?)
      @responses3 = []
    end
    if(@poll.answer_4.blank?)
      @responses4 = []
    end
    @all_responses.each do |r|
      if(r.response_type==1)
        @responses1.push r
      elsif(r.response_type==2)
        @responses2.push r
      elsif(r.response_type==3)
        @responses3.push r
      elsif(r.response_type==4)
        @responses4.push r
      end
    end

  end


end
