class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(receiver_id: current_user.id).order(created_at: :desc).includes({comment: [:blog]})
    @notifications.update_all(read: true)
  end
end
