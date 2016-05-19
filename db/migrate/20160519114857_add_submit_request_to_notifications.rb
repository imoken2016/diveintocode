class AddSubmitRequestToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :submit_request_id, :integer
  end
end
