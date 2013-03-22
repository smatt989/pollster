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
    respond_to do |format|
      format.html
      format.json do
        answer_array = []
        answer_1 = { content: @poll.answer_1, type: "1" }
        answer_2 = { content: @poll.answer_2, type: "2" }
        answer_array.push answer_1
        answer_array.push answer_2
        unless(@poll.answer_3.blank?)
          answer_3 = { content: @poll.answer_3, type: "3" }
          answer_array.push answer_3
        end
        unless(@poll.answer_4.blank?)
          answer_4 = { content: @poll.answer_4, type: "4" }
          answer_array.push answer_4
        end
        jsonreturn = { id: @poll.id, content: @poll.content, answers: answer_array }
        render :json => jsonreturn
      end
    end
  end

  def random
    @completed_polls = []
    current_user.responses.each do |r|
      @completed_polls.push r.poll_id
    end
    if(@completed_polls.blank?)
      @poll = Poll.find(:first)
    else
      @poll = Poll.find(:first, :conditions => ['id not in (?)', @completed_polls] )
    end
    respond_to do |format|
      format.html { redirect_to poll_path(@poll) }
      format.json { redirect_to poll_path( :id => @poll.id, :format => :json ) }
    end
  end

  def created_index
    @polls = []
    current_user.polls.each do |p|
      @polls.push p
    end
  end

  def responded_index
    @polls = []
    current_user.responses.each do |r|
      @polls.push Poll.find_by_id(r.poll_id)
    end
  end

  def analytics
    @poll = Poll.find(params[:id])
    @all_responses = []
    @poll.responses.each do |r|
      @all_responses.push r
    end
    @responses1 = []
    @responses2 = []
    unless(@poll.answer_3.blank?)
      @responses3 = []
    end
    unless(@poll.answer_4.blank?)
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
    respond_to do |format|
      format.html
      format.json do
        jsonreturn = {}
        jsonreturn[:poll] = { id: @poll.id, content: @poll.content }
        answer_array = []
        answer_1 = { content: @poll.answer_1, count: @responses1.count }
        answer_2 = { content: @poll.answer_2, count: @responses2.count }
        answer_array.push answer_1
        answer_array.push answer_2
        unless(@poll.answer_3.blank?)
          answer_3 = { content: @poll.answer_3, count: @responses3.count }
          answer_array.push answer_3
        end
        unless(@poll.answer_4.blank?)
          answer_4 = { content: @poll.answer_4, count: @responses4.count }
          answer_array.push answer_4
        end
        jsonreturn[:analytics] = answer_array
        render :json => jsonreturn
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
