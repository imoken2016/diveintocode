class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :notifications, dependent: :destroy
  has_many :conversations, through: :notifications, source: :comment

  accepts_nested_attributes_for :notifications

  delegate :name, to: :user, prefix: true

end
