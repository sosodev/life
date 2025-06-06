require "test_helper"

class TaskListTest < ActiveSupport::TestCase
  test "should have many tasks" do
    task_list = TaskList.new
    assert_respond_to task_list, :tasks
    assert_respond_to task_list, :tasks=
  end

  test "should destroy associated tasks when task list is destroyed" do
    task_list = TaskList.create!(name: "Test List")

    # Create some tasks for this list
    task1 = Task.create!(name: "Task 1", task_list: task_list)
    task2 = Task.create!(name: "Task 2", task_list: task_list)

    # Verify tasks exist
    assert_equal 2, task_list.tasks.count

    # Destroy the task list and verify tasks are also destroyed
    assert_difference "Task.count", -2 do
      task_list.destroy
    end
  end

  test "should be valid with a name" do
    task_list = TaskList.new(name: "My Task List")
    assert task_list.valid?
  end

  test "should be invalid without a name" do
    task_list = TaskList.new
    assert task_list.invalid?
  end

  test "should persist name correctly" do
    task_list = TaskList.create!(name: "Important Tasks")
    task_list.reload

    assert_equal "Important Tasks", task_list.name
  end

  test "should handle empty task list" do
    task_list = TaskList.create!(name: "Empty List")

    assert_equal 0, task_list.tasks.count
    assert_empty task_list.tasks
  end

  test "should maintain association when tasks are added" do
    task_list = TaskList.create!(name: "Test List")

    task = Task.create!(name: "New Task", task_list: task_list)

    assert_includes task_list.tasks, task
    assert_equal task_list, task.task_list
  end
end
