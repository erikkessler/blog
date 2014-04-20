# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Blog::Application.load_tasks

task :make_admin => :environment do
     newAdmin = User.create(email: "kessler.penguin55@gmail.com", password: "foobar", password_confirmation: "foobar")
     newAdmin.toggle!(:admin)
end
