require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :user => nil,
      :title => "MyString",
      :content => "MyText",
      :charge_id => 1,
      :done => false,
      :status => 1
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_title[name=?]", "task[title]"

      assert_select "textarea#task_content[name=?]", "task[content]"

      assert_select "input#task_charge_id[name=?]", "task[charge_id]"

      assert_select "input#task_done[name=?]", "task[done]"

      assert_select "input#task_status[name=?]", "task[status]"
    end
  end
end
