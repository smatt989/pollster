class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :remember_token, :gender, :birthday, :hometown, :photo_link, :education, :country_code
  has_many :polls, dependent: :destroy
  has_many :responses, dependent: :destroy

  before_save :create_remember_token

  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  def self.create_with_omniauth(auth)
  	create! do |user|
  	  user.provider = auth["provider"]
  	  user.uid = auth["uid"]
  	  user.name = auth["info"]["name"]
      user.gender = auth["extra"]["raw_info"]["gender"]
      user.birthday = auth["extra"]["raw_info"]["birthday"]
      user.hometown = auth["extra"]["raw_info"]["hometown"]
      user.photo_link = "http://graph.facebook.com/"+user.uid+"/picture?type=large"
      user.education = auth["extra"]["raw_info"]["education"]
      user.country_code = auth["extra"]["raw_info"]["locale"]
  	end
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
