require 'rails_helper'

RSpec.describe "project_members/index", type: :view do
  before(:each) do
    assign(:project_members, [
      ProjectMember.create!(
        :project_id => 1,
        :user_id => 2
      ),
      ProjectMember.create!(
        :project_id => 1,
        :user_id => 2
      )
    ])
  end

  it "renders a list of project_members" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
