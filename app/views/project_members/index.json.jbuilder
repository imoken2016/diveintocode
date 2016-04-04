json.array!(@project_members) do |project_member|
  json.extract! project_member, :id, :project_id, :user_id
  json.url project_member_url(project_member, format: :json)
end
