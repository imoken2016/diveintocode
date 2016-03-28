class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy

  #第一段階「中間テーブルと関係を定義する」
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship",dependent: :destroy

  #第二弾階「相対的な参照関係を定義する」
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :tasks, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  scope :followed_users, -> (user_id) do
    joins(:reverse_relationships).where(relationships: { follower_id: user_id })
  end
  scope :follower_users, -> (user_id) do
    joins(:relationships).where(relationships: { followed_id: user_id })
  end

  def image_path
      if self.avatar.url.present?
        self.avatar.url
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

  #指定のユーザーをフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #指定のユーザーをフォローを解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  #フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  #フォローされているかどうかを確認する
  def followed?(other_user)
    reverse_relationships.find_by(follower_id: other_user.id)
  end

  #お互いにフォローしあっているかどうか
  def mutual_followers
    followed_users = User.followed_users(self.id)
    follower_users = User.follower_users(self.id)
    followed_users.where(id: follower_users.ids)
  end


  #自分がフォローしあっているユーザー一覧を取得する
  def friend
    User.from_users_followed_by(self)
  end

  #フォローしあっているユーザー一覧を取得する
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT X.id FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = :user_id) X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = :user_id) Y ON X.id = Y.id"
    where("id IN (#{followed_user_ids})",user_id: user.id)
  end

  #フォローしている人のタスクフィードを取得する
  #def taskfeed
  #  tasks = Task.where(user_id: self)
  #  Task.from_users_followed_by(self).order("updated_at DESC")
  #end

  def taskfeed
    taskfeed_users_ids = self.mutual_followers.ids << self.id
    Task.where(user_id: taskfeed_users_ids)
  end

end
