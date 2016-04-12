# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


20.times do |num|
  @user = User.new(:name => "名無し太朗#{num}", :email => "hogehoge#{num}@example.com", :password => "12345678", :uid => User.create_unique_string, confirmed_at: Time.now)
  @user.skip_confirmation!
  @user.save!
  2.times do |blog_num|
    @post = @user.blogs.create(:title => "できたよ#{blog_num}", :content => "本文いれるよ#{blog_num}")
  end
  1.times do |project_num|
    @project = @user.projects.create(:title => "極秘プロジェクトX_#{project_num}", :content => "プロジェクトの本文", :customer_id => 1, :user_id => @user.id)
  end
  2.times do |task_num|
    @task = @user.tasks.create(:title => "できたよ#{task_num}", :content => "本文いれるよ#{task_num}", :charge_id => @user.id, :project_id => @project.id)
  end
end

5.times do |num|
  @customer = Customer.new(:name => "サンプル顧客#{num}", :content => "本文いれるよ#{num}" )
  @customer.save!
end
