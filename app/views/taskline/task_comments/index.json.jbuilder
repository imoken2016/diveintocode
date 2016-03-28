json.array!(@taskline_task_comments) do |taskline_task_comment|
  json.extract! taskline_task_comment, :id, :user, :task_id, :content
  json.url taskline_task_comment_url(taskline_task_comment, format: :json)
end
