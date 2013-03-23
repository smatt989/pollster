class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
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
  	end
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
