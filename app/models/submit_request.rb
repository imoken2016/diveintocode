class SubmitRequest < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :charger, class_name: 'User',foreign_key: "charge_id"

  def status_display_name
    case status
      when 1
        "未承認"
      when 2
        "承認済"
      when 8
        "取消済"
      when 9
        "却下"
    end
  end

  def client_name
    User.find(user_id).name
  end

  def charger_name(user)
    charge_id == user.id ? "（自分）" : charger.name
  end
end
