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

  def created_index
    @polls = []
    current_user.polls.each do |p|
      @polls.push p
    end
    @polls.paginate(page: params[:page])
  end

  def responded_index
    @polls = []
    current_user.responses.each do |r|
      @polls.push Poll.find_by_id(r.poll_id)
    end
    @polls.paginate(page: params[:page])
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

  def previous
    @response = current_user.responses.find_by_poll_id(params[:id])
    if(@response) #if not hitting previous from the most recent unanswered poll
      @poll = Poll.find_by_id((current_user.responses.find(:last, :conditions => ["id < (?)", @response.id])).poll_id) unless @response == current_user.responses.find(:first)
    else #if hitting previous form teh most recent unanswered poll
      @poll = Poll.find_by_id((current_user.responses.find(:last)).poll_id)
    end
    if(@poll) #if not the first poll taken
      redirect_to analytics_poll_path(@poll)
    else #if the first poll taken
      redirect_to root_path
    end
  end

  def next
    @response = current_user.responses.find_by_poll_id(params[:id])
    if(@response) #if not the -1st poll (not on the screen that says you have no more polls)
      @poll = Poll.find_by_id((current_user.responses.find(:first, :conditions => ["id > (?)", @response.id])).poll_id) unless @response == current_user.responses.find(:last)
    else
      @poll = Poll.find_by_id((current_user.responses.find(:first)))
    end
    if(@poll) #if not the last poll (the random one they should be doing now)
      redirect_to analytics_poll_path(@poll)
    else #if the last poll (the random one)
      redirect_to random_path
    end
  end

end
