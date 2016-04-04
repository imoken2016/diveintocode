require 'rails_helper'

RSpec.describe "project_members/show", type: :view do
  before(:each) do
    @project_member = assign(:project_member, ProjectMember.create!(
      :project_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
