# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#blog = Blog.create([{ title: 'できた！', content: '本文を入れるよ',user_id: 28 }])
#User.create(id: 28, blog_id: blog.first)
#user = User.create(id: 28)
#Blog.create([{ title: 'できた！', content: '本文を入れるよ',user_id: user.id }])
#Title.create(:name => '観察日記', :sales_date => '2011-11-14', :price => 1000)



30.times do |num|
  @user = User.new(:name => "名無し太朗#{num}", :email => "hogehoge#{num}@example.com", :password => "12345678", :uid => User.create_unique_string, confirmed_at: Time.now)
  @user.skip_confirmation!
  @user.save!
  3.times do |blog_num|
    @post = @user.blogs.create(:title => "できたよ#{blog_num}", :content => "本文いれるよ#{blog_num}")
  end
end

