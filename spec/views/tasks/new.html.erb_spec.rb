require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :user => nil,
      :title => "MyString",
      :content => "MyText",
      :charge_id => 1,
      :done => false,
      :status => 1
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_title[name=?]", "task[title]"

      assert_select "textarea#task_content[name=?]", "task[content]"

      assert_select "input#task_charge_id[name=?]", "task[charge_id]"

      assert_select "input#task_done[name=?]", "task[done]"

      assert_select "input#task_status[name=?]", "task[status]"
    end
  end
end
