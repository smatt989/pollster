class Poll < ActiveRecord::Base
  attr_accessible :content, :answer_1, :answer_2, :answer_3, :answer_4
  belongs_to :user
  has_many :responses

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :answer_1, presence: true, length: { minimum: 1, maximum: 50 }
  validates :answer_2, presence: true, length: { minimum: 1, maximum: 50 }
  validates :answer_3, length: { minimum: 1, maximum: 50 }, :allow_blank => true
  validates :answer_4, length: { minimum: 1, maximum: 50 }, :allow_blank => true

  #default_scope order: 'polls.created_at DESC'
  def formatted_json_poll
    answer_array = []
    answer_1 = { content: self.answer_1, type: 1 }
    answer_2 = { content: self.answer_2, type: 2 }
    answer_array.push answer_1
    answer_array.push answer_2
    unless(self.answer_3.blank?)
      answer_3 = { content: self.answer_3, type: 3 }
      answer_array.push answer_3
    end
    unless(self.answer_4.blank?)
      answer_4 = { content: self.answer_4, type: 4 }
      answer_array.push answer_4
    end
    jsonreturn = { id: self.id, content: self.content, answers: answer_array }
  end

  def formatted_json_poll_analytics(responses1,responses2,responses3,responses4)
  	jsonreturn = {}
    jsonreturn[:poll] = { id: self.id, content: self.content }
    answer_array = []
    answer_1 = { content: self.answer_1, count: responses1.count }
    answer_2 = { content: self.answer_2, count: responses2.count }
    answer_array.push answer_1
    answer_array.push answer_2
    unless(self.answer_3.blank?)
      answer_3 = { content: self.answer_3, count: responses3.count }
      answer_array.push answer_3
    end
    unless(self.answer_4.blank?)
      answer_4 = { content: self.answer_4, count: responses4.count }
      answer_array.push answer_4
    end
    jsonreturn[:analytics] = answer_array
  end

end
