require 'rails_helper'

RSpec.describe "project_members/edit", type: :view do
  before(:each) do
    @project_member = assign(:project_member, ProjectMember.create!(
      :project_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit project_member form" do
    render

    assert_select "form[action=?][method=?]", project_member_path(@project_member), "post" do

      assert_select "input#project_member_project_id[name=?]", "project_member[project_id]"

      assert_select "input#project_member_user_id[name=?]", "project_member[user_id]"
    end
  end
end
