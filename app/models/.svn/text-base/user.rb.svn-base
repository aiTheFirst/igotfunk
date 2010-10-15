require 'digest/sha1'

# A User is a person that accesses the website
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  
  belongs_to :user_type
  has_many :rankings
  has_many :story_comments
  has_many :statuses
  has_many :stories
  
  # Every user should have one profile
  has_one :user_profile

  validates_presence_of     :login, :email, :message => 'This is a required field.'
  validates_presence_of     :password,                   :if => :password_required?, :message => 'This is a required field.'
  validates_presence_of     :password_confirmation,      :if => :password_required?, :message => 'This is a required field.'
  validates_length_of       :password, :within => 4..40, :if => :password_required?, :too_long => 'This is too long.', :too_short => 'This is too short.'
  validates_confirmation_of :password,                   :if => :password_required?, :message => 'Passwords must match.'
  validates_length_of       :login,    :within => 3..40, :too_long => 'This is too long.', :too_short => 'This is too short.'
  validates_length_of       :email,    :within => 3..100, :too_long => 'This is too long.', :too_short => 'This is too short.'
  validates_uniqueness_of   :email, :case_sensitive => false, :message => 'This e-mail has already been registered.'
  validates_uniqueness_of   :login, :message => 'This name is already taken.'
  
  validates_format_of :login, :with => /^[A-Za-z0-9_]+$/i, :message => 'Can only contain letters, numbers, and underscores.'
  
  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end
  
  def self.find_user_login_by_id(user_id)
    @user = User.find :first,
                      :select => 'login', 
                      :conditions => ['id = ?', user_id]
    return @user.login
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    
end
