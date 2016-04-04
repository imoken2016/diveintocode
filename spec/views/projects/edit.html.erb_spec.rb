require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :title => "MyString",
      :content => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input#project_title[name=?]", "project[title]"

      assert_select "textarea#project_content[name=?]", "project[content]"

      assert_select "input#project_user_id[name=?]", "project[user_id]"
    end
  end
end
