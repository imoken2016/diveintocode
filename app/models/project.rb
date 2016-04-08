class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_members
  has_many :users, through: :project_members
  has_many :tasks, dependent: :destroy

  def user_name
    User.find(self.user_id).name
  end

end
