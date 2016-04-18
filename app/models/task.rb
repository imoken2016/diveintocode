class Task < ActiveRecord::Base
  has_many :submit_request, dependent: :destroy
  has_many :task_comments, dependent: :destroy
  has_many :goodjobs, dependent: :destroy
  belongs_to :user
  belongs_to :project
  belongs_to :charge, class_name:'User', foreign_key: 'charge_id'
  validates :content, presence: true

  #フォローしているユーザー一覧を取得
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT X.id FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = :user_id) X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = :user_id) Y ON X.id = Y.id"
    where("user_id IN (#{followed_user_ids}) OR user_id = user_id",user_id: user.id)
  end

  STATUS_LIST = [["未着手", 0], ["対応中", 1]]

  def charge_user_name
    charge.name
  end

  def status_display_name
    status == 1 ? "対応中" : "未着手"
  end

  def done_display_name
    done ? "完了" : "未完了"
  end

  def self.status_list
    STATUS_LIST
  end

end
