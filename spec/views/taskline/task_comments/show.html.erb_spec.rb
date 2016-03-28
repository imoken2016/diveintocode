require 'rails_helper'

RSpec.describe "taskline/task_comments/show", type: :view do
  before(:each) do
    @taskline_task_comment = assign(:taskline_task_comment, Taskline::TaskComment.create!(
      :user => "",
      :task => nil,
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Content/)
  end
end
