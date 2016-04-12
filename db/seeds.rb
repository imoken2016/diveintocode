# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


30.times do |num|
  @user = User.new(:name => "名無し太朗#{num}", :email => "hogehoge#{num}@example.com", :password => "12345678", :uid => User.create_unique_string, confirmed_at: Time.now)
  @user.skip_confirmation!
  @user.save!
  2.times do |blog_num|
    @post = @user.blogs.create(:title => "できたよ#{blog_num}", :content => "本文いれるよ#{blog_num}")
  end
  2.times do |task_num|
    @task = @user.tasks.create(:title => "できたよ#{task_num}", :content => "本文いれるよ#{task_num}", :charge_id => @user.id)
  end
end

odd = User.find_by_email('hogehoge0@example.com')
Task.create(title: "Task 0", content: "TC 0", done: true, user: even, charge: even)
1.upto(100) do |n|
  Task.create(title: "Task #{n}", content: "TC #{n}", done: false, user: n.even? ? even : odd, charge: e.even? ? even : odd)
end


