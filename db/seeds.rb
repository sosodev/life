# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  task_list = TaskList.create!(name: "test")

  (1..100).each do |i|
    parent_task = Task.create!(name: "Test-#{i}", task_list: task_list)
    Task.create!(name: "Child-Test-#{i}", parent: parent_task, task_list: task_list)
  end
end
