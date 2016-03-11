class Relationship < ActiveRecord::Base
  #第二弾階「フォロー・フォロワーの識別を定義する」
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
