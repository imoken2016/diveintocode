module BlogsHelper
  def timeline_blogs?(user)
    current_user == user || (current_user.following?(user) && current_user.followed?(user))
  end
end
