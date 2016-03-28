require 'rails_helper'

RSpec.describe "taskline/task_comments/index", type: :view do
  before(:each) do
    assign(:taskline_task_comments, [
      Taskline::TaskComment.create!(
        :user => "",
        :task => nil,
        :content => "Content"
      ),
      Taskline::TaskComment.create!(
        :user => "",
        :task => nil,
        :content => "Content"
      )
    ])
  end

  it "renders a list of taskline/task_comments" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
