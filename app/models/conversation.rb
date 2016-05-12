class Conversation < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)",
          sender_id, recipient_id, recipient_id, sender_id)
  end

  def recipient(user)
    user.id == sender_id || recipient_id ? User.find(recipient_id) : User.find(sender_id)
  end

  def read(user)
    unread_messages = self.messages.where(user_id: user.id, read: false)
    unread_messages.each do |message|
      message.read = true
      message.save
    end
  end


end
