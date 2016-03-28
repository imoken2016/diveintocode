require "rails_helper"

RSpec.describe Taskline::TaskCommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/taskline/task_comments").to route_to("taskline/task_comments#index")
    end

    it "routes to #new" do
      expect(:get => "/taskline/task_comments/new").to route_to("taskline/task_comments#new")
    end

    it "routes to #show" do
      expect(:get => "/taskline/task_comments/1").to route_to("taskline/task_comments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/taskline/task_comments/1/edit").to route_to("taskline/task_comments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/taskline/task_comments").to route_to("taskline/task_comments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/taskline/task_comments/1").to route_to("taskline/task_comments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/taskline/task_comments/1").to route_to("taskline/task_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/taskline/task_comments/1").to route_to("taskline/task_comments#destroy", :id => "1")
    end

  end
end
