require 'rails_helper'

RSpec.describe "Taskline::TaskComments", type: :request do
  describe "GET /taskline_task_comments" do
    it "works! (now write some real specs)" do
      get taskline_task_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
