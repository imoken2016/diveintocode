require 'rails_helper'

RSpec.describe "taskline/task_comments/new", type: :view do
  before(:each) do
    assign(:taskline_task_comment, Taskline::TaskComment.new(
      :user => "",
      :task => nil,
      :content => "MyString"
    ))
  end

  it "renders new taskline_task_comment form" do
    render

    assert_select "form[action=?][method=?]", taskline_task_comments_path, "post" do

      assert_select "input#taskline_task_comment_user[name=?]", "taskline_task_comment[user]"

      assert_select "input#taskline_task_comment_task_id[name=?]", "taskline_task_comment[task_id]"

      assert_select "input#taskline_task_comment_content[name=?]", "taskline_task_comment[content]"
    end
  end
end
