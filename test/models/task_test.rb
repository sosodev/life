require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should belong to task_list" do
    task = Task.new
    assert_respond_to task, :task_list
    assert_respond_to task, :task_list=
  end

  test "should belong to parent task optionally" do
    task = Task.new
    assert_respond_to task, :parent
    assert_respond_to task, :parent=

    # Should be valid without a parent
    task = Task.new(name: "Test Task", task_list: task_lists(:one))
    assert task.valid?
  end

  test "should have many children tasks" do
    parent_task = tasks(:one)
    assert_respond_to parent_task, :children

    child_task = Task.create!(
      name: "Child Task",
      task_list: parent_task.task_list,
      parent: parent_task
    )

    assert_includes parent_task.children, child_task
  end

  test "should destroy children when parent is destroyed" do
    parent_task = tasks(:one)
    child_task = Task.create!(
      name: "Child Task",
      task_list: parent_task.task_list,
      parent: parent_task
    )

    assert_difference "Task.count", -2 do
      parent_task.destroy
    end
  end

  test "should serialize estimate as duration" do
    task = Task.new

    # Test setting with ActiveSupport::Duration
    task.estimate = 2.hours
    assert_equal 2.hours, task.estimate

    # Test setting with numeric value (seconds)
    task.estimate = 3600
    assert_equal 1.hour, task.estimate
  end

  test "should serialize time_taken as duration" do
    task = Task.new

    # Test setting with ActiveSupport::Duration
    task.time_taken = 90.minutes
    assert_equal 90.minutes, task.time_taken

    # Test setting with numeric value (seconds)
    task.time_taken = 1800
    assert_equal 30.minutes, task.time_taken
  end

  test "should serialize recur_after as duration" do
    task = Task.new

    # Test setting with ActiveSupport::Duration
    task.recur_after = 1.week
    assert_equal 1.week, task.recur_after

    # Test setting with numeric value (seconds)
    task.recur_after = 86400
    assert_equal 1.day, task.recur_after
  end

  test "should handle nil values for duration fields" do
    task = Task.new

    task.estimate = nil
    assert_nil task.estimate

    task.time_taken = nil
    assert_nil task.time_taken

    task.recur_after = nil
    assert_nil task.recur_after
  end

  test "should persist duration fields correctly" do
    task = Task.create!(
      name: "Test Task",
      task_list: task_lists(:one),
      estimate: 2.hours,
      time_taken: 90.minutes,
      recur_after: 1.week
    )

    task.reload

    assert_equal 2.hours, task.estimate
    assert_equal 90.minutes, task.time_taken
    assert_equal 1.week, task.recur_after
  end

  test "should handle finished_at timestamp" do
    task = Task.new(name: "Test Task", task_list: task_lists(:one))

    assert_nil task.finished_at

    now = Time.current
    task.finished_at = now
    assert_equal now.to_i, task.finished_at.to_i
  end
end
