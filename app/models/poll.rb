class Poll < ActiveRecord::Base
  attr_accessible :content, :answer_1, :answer_2, :answer_3, :answer_4
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :answer_1, presence: true, length: { minimum: 1, maximum: 50 }
  validates :answer_2, presence: true, length: { minimum: 1, maximum: 50 }
  validates :answer_3, length: { minimum: 1, maximum: 50 }, :allow_blank => true
  validates :answer_4, length: { minimum: 1, maximum: 50 }, :allow_blank => true

  default_scope order: 'polls.created_at DESC'
end
