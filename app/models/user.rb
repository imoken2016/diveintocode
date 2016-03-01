class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  has_many :blogs, :dependent => :delete_all
  has_many :comments
  
  mount_uploader :avatar, AvatarUploader

  def image_path
      if self.avatar.thumb.url.present?
        self.avatar.thumb.url
      elsif self.image.present?
        self.image
      else
        'noimage.png'
      end
  end
  
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
    fb_email = auth.info.email.present? ? auth.info.email : User.create_unique_email

      user = User.create(name: auth.extra.raw_info.name, 
                         provider: auth.provider,
                         uid: auth.uid, 
                         email: fb_email,
                         image: auth.info.image,
                         password: Devise.friendly_token[0,20],
                         confirmed_at: Time.now
                         ) 
    end 
    user
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
      user = User.create(name: auth.info.nickname,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: User.create_unique_email,
                         image: auth.info.image,
                         password: Devise.friendly_token[0,20],
                         confirmed_at: Time.now
                         ) 
    end 
    user
  end
  
  def self.create_unique_string 
    SecureRandom.uuid
  end
  
  def self.create_unique_email 
    User.create_unique_string + "@example.com" 
  end
  
end
