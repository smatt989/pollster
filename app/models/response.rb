class Response < ActiveRecord::Base
  attr_accessible :content, :poll_id, :response_type, :user_id
  belongs_to :user
  belongs_to :poll
end
