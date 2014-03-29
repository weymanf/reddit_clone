class User < ActiveRecord::Base
  attr_reader :password

  before_validation :ensure_session_token

  validates :username, :presence => true
  validates :password, :length => {:minimum => 6, :allow_nil => true}

  has_many :subs
  has_many :links
  has_many :comments
  has_many :user_votes

  def self.find_by_credentials(username,password)
    user = User.find_by_username(username)
    user && user.is_password?(password) ? user : nil
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def is_moderator_of(sub)
    sub.moderator == self
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save

    self.session_token
  end

end
