class Response < ActiveRecord::Base
  attr_accessible :content, :poll_id, :response_type, :user_id
  belongs_to :user
  belongs_to :poll
  validates :content, presence: true, length: { minimum: 1, maximum: 50 }
  validates :poll_id, presence: true
  validates :response_type, presence: true
end
