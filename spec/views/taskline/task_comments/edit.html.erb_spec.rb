require 'rails_helper'

RSpec.describe "taskline/task_comments/edit", type: :view do
  before(:each) do
    @taskline_task_comment = assign(:taskline_task_comment, Taskline::TaskComment.create!(
      :user => "",
      :task => nil,
      :content => "MyString"
    ))
  end

  it "renders the edit taskline_task_comment form" do
    render

    assert_select "form[action=?][method=?]", taskline_task_comment_path(@taskline_task_comment), "post" do

      assert_select "input#taskline_task_comment_user[name=?]", "taskline_task_comment[user]"

      assert_select "input#taskline_task_comment_task_id[name=?]", "taskline_task_comment[task_id]"

      assert_select "input#taskline_task_comment_content[name=?]", "taskline_task_comment[content]"
    end
  end
end
